# 多阶段构建：builder 构建，runner 仅保留运行所需文件并以非 root 用户运行
FROM node:22-alpine AS base

# --- Build stage ---
FROM base AS builder
WORKDIR /app

# 先装依赖，利用 Docker 层缓存
# 用 npm install 而非 npm ci：npm ci 严格按本地(macOS)生成的 lockfile 安装，
# 会漏装 linux 平台的 optional 依赖（如 rolldown native binding），导致构建失败
COPY package.json package-lock.json ./
RUN npm install --no-audit --no-fund

# 拷贝源码并构建
COPY . .
RUN npm run build

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
# 注意：不复制 /app/node_modules（约 334MB，几乎全是 vite/rollup/typescript 等构建期工具）。
# Nitro 的 node-server 产物 .output 已自包含运行时依赖（.output/server/node_modules 仅约 5MB），
# 只复制 .output 即可让镜像从 ~490MB 降到 ~160MB。
COPY --from=builder --chown=nextjs:nodejs /app/.output ./.output
COPY --from=builder --chown=nextjs:nodejs /app/package.json ./

# 数据目录（宿主机 bind mount 到 /app/data）
RUN mkdir -p /app/data && chown nextjs:nodejs /app/data

USER nextjs

EXPOSE 3000

# node-server preset 产物自带 HTTP server + 静态资源服务（gzip/brotli 协商）
CMD ["node", ".output/server/index.mjs"]
