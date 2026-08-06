# 🔥 NewsHub - 热点内容聚合器

一个高性能的热点内容聚合器，从微博、知乎、百度、哔哩哔哩、酷安、华尔街见闻等 **35+ 平台**实时抓取热搜与热门内容，提供统一的浏览界面。基于 **Nuxt 4 + Nitro** 全栈架构，支持 Docker 一键部署。

🌐 在线体验：<https://newshub.shenzjd.com>

![NewsHub 预览](https://gcore.jsdelivr.net/gh/wu529778790/image/blog/20251230211419.png)

## ✨ 功能特性

- **多平台聚合**：35+ 数据源，覆盖**国内热点 / 科技 / 财经 / 国际**四大分类
- **分类筛选**：一键切换栏目，实时显示各分类数据源数量
- **双布局视图**：网格 / 列表布局自由切换
- **搜索与刷新**：关键词实时过滤，支持一键全局刷新
- **深色模式**：明暗主题一键切换，偏好自动记忆（localStorage）
- **智能缓存**：内存 + 文件双层缓存，自动过期，空数据快速重试，大幅减少源站请求
- **丰富 API**：热榜 JSON、分享图片、批量获取、SSE 流式、健康检查等
- **响应式设计**：移动端 / 桌面端完美适配，DaisyUI + Tailwind CSS
- **自动部署**：GitHub Actions 自动构建 Docker 镜像并部署到服务器

## 🚀 快速开始

### 本地开发

```bash
# 1. 安装依赖（首次）
pnpm install

# 2. 启动开发服务器
pnpm dev
# 访问 http://localhost:3000
```

常用命令：

```bash
pnpm dev             # 开发模式（http://localhost:3000）
pnpm build           # 构建生产版本
pnpm preview         # 预览生产构建
pnpm type-check      # TypeScript 类型检查
pnpm test            # 运行单元测试
pnpm clean           # 清理构建产物
```

## 🐳 Docker 部署

### 方式一：直接运行镜像

```bash
docker run -d -p 3000:3000 \
  --name newshub \
  --restart unless-stopped \
  wu529778790/newshub.shenzjd.com:latest
```

### 方式二：Docker Compose

```bash
# 克隆仓库到服务器后
docker compose up -d

# 查看日志
docker compose logs -f
```

镜像同时发布到两个仓库：

| 仓库 | 地址 |
|------|------|
| Docker Hub | `docker.io/wu529778790/newshub.shenzjd.com` |
| GitHub Container Registry | `ghcr.io/wu529778790/newshub.shenzjd.com` |

### 方式三：GitHub Actions 自动部署（推荐）

推送代码到 `main` 分支后，CI/CD 流水线会自动完成 **构建镜像 → 推送镜像 → SSH 登录服务器 → 拉取最新镜像并重启容器** 的完整流程：

```
push → 构建并推送 Docker 镜像 (build-and-push)
     → 部署到服务器 (deploy)：docker compose pull && docker compose up -d
```

使用前需要在 GitHub 仓库 **Settings → Secrets and variables → Actions** 中配置以下密钥：

| Secret | 说明 | 示例 |
|--------|------|------|
| `DOCKER_USERNAME` | Docker Hub 用户名（构建推送用） | `your-dockerhub-name` |
| `DOCKER_PASSWORD` | Docker Hub 访问令牌 | `xxxxx` |
| `DEPLOY_HOST` | 服务器 IP 或域名 | `1.2.3.4` |
| `DEPLOY_USERNAME` | 服务器 SSH 登录用户名 | `root` |
| `DEPLOY_KEY` | 服务器 SSH 私钥（登录用） | `-----BEGIN OPENSSH PRIVATE KEY-----...` |
| `DEPLOY_PORT` | 服务器 SSH 端口（可选，默认 22） | `22` |

服务器需预装 **Docker + Docker Compose**，并开放目标端口。首次部署时 CI 会自动在服务器 `~/apps/newshub/` 下写入 `docker-compose.yml` 并启动服务。

### 手动构建

```bash
docker build -t newshub .
docker run -p 3000:3000 newshub
```

## 📡 数据源列表（35）

### 🇨🇳 国内热点（15）

| 平台 | 子源 | 源 ID |
|------|------|-------|
| 微博 | 实时热搜 | `weibo` |
| 知乎 | 热榜 | `zhihu` |
| 百度 | 实时热搜 | `baidu` |
| 哔哩哔哩 | 热搜 / 热门视频 / 排行榜 | `bilibili` `bilibili-hot-search` `bilibili-hot-video` `bilibili-ranking` |
| 抖音 | 热门 | `douyin` |
| 快手 | 热门 | `kuaishou` |
| 虎扑 | 主干道热帖 | `hupu` |
| 百度贴吧 | 热议 | `tieba` |
| 今日头条 | 热点 | `toutiao` |
| 澎湃新闻 | 热榜 | `thepaper` |
| 凤凰网 | 热点资讯 | `ifeng` |
| 牛客 | 讨论热点 | `nowcoder` |

### 💻 科技开发（10）

| 平台 | 子源 | 源 ID |
|------|------|-------|
| 酷安 | 今日最热 | `coolapk` |
| 36氪 | 快讯 ×2 | `36kr` `36kr-quick` |
| IT之家 | 要闻 | `ithome` |
| 稀土掘金 | 热门 | `juejin` |
| 少数派 | 热门 | `sspai` |
| GitHub | Trending / Today | `github` `github-trending-today` |
| Solidot | 奇客资讯 | `solidot` |
| 远景论坛 | Win11 | `pcbeta-windows11` |

### 💰 金融财经（8）

| 平台 | 子源 | 源 ID |
|------|------|-------|
| 华尔街见闻 | 最新 / 新闻 / 最热 | `wallstreetcn` `wallstreetcn-news` `wallstreetcn-hot` |
| 雪球 | 热门股票 | `xueqiu` |
| 格隆汇 | 事件 | `gelonghui` |
| 法布财经 | 快讯 / 头条 | `fastbull` `fastbull-news` |
| 金十数据 | 实时快讯 | `jin10` |

### 🌍 国际资讯（2）

| 平台 | 子源 | 源 ID |
|------|------|-------|
| 参考消息 | 要闻 | `cankaoxiaoxi` |
| 卫星通讯社 | 中文要闻 | `sputniknewscn` |

## 🔍 API 文档

| 接口 | 说明 | 示例 |
|------|------|------|
| `GET /api/sources` | 获取全部数据源元信息（名称、分类、图标等） | `/api/sources` |
| `GET /api/hot/{source}` | 获取单个数据源热榜，`?force=1` 强制刷新缓存 | `/api/hot/weibo` |
| `GET /api/hot-list?id={source}` | 获取单源完整热榜数据，`?refresh=true` 强制刷新 | `/api/hot-list?id=zhihu` |
| `GET /api/image/{source}` | 生成热点分享图片（PNG） | `/api/image/baidu` |
| `GET /api/proxy/img.png` | 图片代理（防盗链 / 缓存） | `/api/proxy/img.png?url=...` |
| `GET /api/latest` | 获取当前版本号 | `/api/latest` |
| `GET /api/v1/health` | 健康检查（Docker healthcheck 使用） | `/api/v1/health` |
| `GET /api/v1/batch` | 批量获取多个数据源 | `/api/v1/batch?ids=weibo,zhihu` |
| `GET /api/v1/stream` | SSE 流式推送热榜数据 | `/api/v1/stream` |
| `GET /api/v1/metrics` | 运行指标（缓存命中率、抓取耗时等） | `/api/v1/metrics` |

## 📝 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `HOST` | `0.0.0.0` | 服务监听地址 |
| `PORT` | `3000` | 服务端口 |
| `NODE_ENV` | `production` | 运行环境 |
| `SITE_URL` | - | 站点对外地址（用于生成分享图等） |
| `API_SECRET` | - | API 访问密钥（可选，开启后需携带 `Authorization` 头） |

## 🏗️ 项目结构

```
├── app.vue                  # 应用入口（主题管理、返回顶部）
├── pages/
│   ├── index.vue            # 首页（分类筛选、双布局、搜索）
│   ├── api.vue              # API 使用说明页
│   └── components/          # 页面组件（Header、LoadingState 等）
├── composables/             # 前端共享逻辑
├── server/
│   ├── api/                 # Nitro API 路由
│   ├── sources/             # 各平台抓取适配器（weibo.ts、zhihu.ts...）
│   ├── services/            # 业务服务（源注册、热榜服务等）
│   ├── utils/               # 工具（缓存、抓取、代理、校验）
│   └── database/            # 缓存持久化
├── shared/                  # 跨端共享（源配置、类型、常量）
├── data/cache/              # 缓存数据文件
├── Dockerfile               # 单阶段容器构建
├── docker-compose.yml       # Docker Compose 编排
└── .github/workflows/       # CI/CD（镜像构建 + 自动部署）
```

## 🛠️ 开发指南：添加新数据源

1. **创建抓取器**：在 `server/sources/` 新建文件

```typescript
// server/sources/new-platform.ts
import { defineSource } from "~/server/utils/source";

export default defineSource({
  "new-platform": async () => {
    // 实现抓取逻辑，返回新闻条目数组
    return [
      {
        id: "unique-id",
        title: "标题",
        url: "https://example.com",
        extra: { info: "附加信息" },
      },
    ];
  },
});
```

2. **注册配置**：在 `shared/sources.json` 中添加源信息（名称、分类 `column`、刷新间隔 `interval`、颜色等）

```json
{
  "new-platform": {
    "name": "新平台",
    "type": "hottest",
    "column": "tech",
    "home": "https://example.com",
    "color": "blue",
    "interval": 600000
  }
}
```

3. **本地验证**：`pnpm dev` 后访问 `http://localhost:3000/api/hot/new-platform`

## 🚀 性能设计

- **并行抓取**：多源请求并发执行，互不阻塞
- **双层缓存**：内存缓存优先、文件缓存兜底，命中后直接返回
- **智能过期**：有数据缓存 1 小时、空数据缓存 1 分钟（失败快速重试）
- **懒加载渲染**：按可见区域分批渲染，首屏快速呈现
- **错误隔离**：单个数据源失败不影响其他源展示

## 📄 许可证

[MIT](LICENSE)
