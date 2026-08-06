# 多阶段构建：builder 构建，runner 仅保留运行所需文件并以非 root 用户运行
FROM node:20-alpine AS base

# --- Build stage ---
FROM base AS builder
WORKDIR /app

# 安装 pnpm
RUN npm install -g pnpm

# 先装依赖，利用 Docker 层缓存
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# 拷贝源码并构建
COPY . .
RUN pnpm build

# --- Production stage ---
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000
ENV HOST=0.0.0.0

# 非 root 用户（UID 1001），与宿主机挂载目录属主保持一致
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

# 只复制运行所需文件
COPY --from=builder --chown=nextjs:nodejs /app/.output ./.output
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nextjs:nodejs /app/package.json ./
COPY --from=builder --chown=nextjs:nodejs /app/start.mjs ./

# 数据目录（宿主机 bind mount 到 /app/data）
RUN mkdir -p /app/data && chown nextjs:nodejs /app/data

USER nextjs

EXPOSE 3000

CMD ["node", "start.mjs"]
