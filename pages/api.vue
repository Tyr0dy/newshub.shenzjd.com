<template>
  <div class="min-h-screen bg-gradient-to-br from-base-100 via-base-50 to-base-100">
    <!-- 头部 -->
    <header class="sticky top-0 z-50 bg-base-100/80 backdrop-blur-md border-b border-base-300/50">
      <div class="container mx-auto px-6 py-4">
        <div class="flex items-center justify-between">
          <div class="flex items-center space-x-3">
            <!-- 返回首页按钮 -->
            <NuxtLink to="/" class="btn btn-ghost btn-sm">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
              </svg>
              返回首页
            </NuxtLink>
            <div>
              <h1 class="text-xl font-bold bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
                API 文档
              </h1>
              <p class="text-xs text-base-content/60">
                所有可用的 API 接口和使用说明
              </p>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- 主内容 -->
    <main class="container mx-auto px-6 py-8">
      <!-- 简介卡片 -->
      <div class="card bg-base-100 shadow-xl mb-8">
        <div class="card-body">
          <h2 class="card-title text-2xl">📚 API 接口文档</h2>
          <p class="text-base-content/70 mt-2">
            本项目提供 RESTful API 接口，支持实时获取各大平台的热点数据。所有 API 均返回 JSON 格式数据。
          </p>
          <div class="badge badge-primary gap-2 mt-4">v1.0</div>
        </div>
      </div>

      <!-- API 分类：数据源相关 -->
      <div class="mb-8">
        <h3 class="text-xl font-bold mb-4 flex items-center gap-2">
          <span class="badge badge-primary badge-outline">数据源</span>
          Data Sources
        </h3>
        <div class="grid grid-cols-1 xl:grid-cols-2 gap-4">
          <!-- /api/v1/sources -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/sources</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">获取所有数据源列表及其配置信息</p>

              <div class="divider my-2">查询参数</div>
              <div class="text-xs space-y-1">
                <div class="flex gap-2">
                  <code class="badge badge-ghost">includeDisabled</code>
                  <span class="text-base-content/60">是否包含禁用的源</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">metrics</code>
                  <span class="text-base-content/60">是否包含性能指标</span>
                </div>
              </div>

              <div class="divider my-2">请求示例</div>
              <div class="mock mock-code bg-base-300 text-xs">
                <pre>curl "https://your-site.com/api/v1/sources?metrics=true"</pre>
              </div>

              <div class="divider my-2">响应示例</div>
              <div class="mock mock-code bg-base-300 text-xs">
                <pre>{
  "apiVersion": "1.0",
  "timestamp": 1703980800000,
  "count": 27,
  "sources": [
    {
      "id": "weibo",
      "name": "微博热搜",
      "home": "https://s.weibo.com",
      "type": "hot",
      "interval": 120,
      "enabled": true,
      "column": "china",
      "color": "#ff8200"
    }
  ]
}</pre>
              </div>
            </div>
          </div>

          <!-- /api/v1/sources/{id} -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/sources/[id]</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">获取单个数据源的详细信息</p>

              <div class="divider my-2">路径参数</div>
              <div class="text-xs space-y-1">
                <div class="flex gap-2">
                  <code class="badge badge-ghost">id</code>
                  <span class="text-base-content/60">数据源ID (e.g., weibo, zhihu)</span>
                </div>
              </div>

              <div class="divider my-2">请求示例</div>
              <div class="mock mock-code bg-base-300 text-xs">
                <pre>curl "https://your-site.com/api/v1/sources/weibo"</pre>
              </div>
            </div>
          </div>

          <!-- /api/v1/batch -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/batch</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">批量获取多个数据源的数据</p>

              <div class="divider my-2">查询参数</div>
              <div class="text-xs space-y-1">
                <div class="flex gap-2">
                  <code class="badge badge-ghost">sources</code>
                  <span class="text-base-content/60">逗号分隔的源ID (必填)</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">force</code>
                  <span class="text-base-content/60">强制刷新缓存</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">limit</code>
                  <span class="text-base-content/60">每源条数限制 (1-50)</span>
                </div>
              </div>

              <div class="divider my-2">请求示例</div>
              <div class="mock mock-code bg-base-300 text-xs">
                <pre>curl "https://your-site.com/api/v1/batch?sources=weibo,zhihu,baidu&limit=10"</pre>
              </div>
            </div>
          </div>

          <!-- /api/hot-list -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/hot-list</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">获取单个数据源的热点数据（旧版）</p>

              <div class="divider my-2">查询参数</div>
              <div class="text-xs space-y-1">
                <div class="flex gap-2">
                  <code class="badge badge-ghost">id</code>
                  <span class="text-base-content/60">数据源ID (必填)</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">refresh</code>
                  <span class="text-base-content/60">强制刷新 (true/false)</span>
                </div>
              </div>

              <div class="divider my-2">请求示例</div>
              <div class="mock mock-code bg-base-300 text-xs">
                <pre>curl "https://your-site.com/api/hot-list?id=weibo&refresh=true"</pre>
              </div>
            </div>
          </div>

          <!-- /api/v1/sources/hot/batch -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/sources/hot/batch</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">热点数据批量获取（带并发控制）</p>

              <div class="divider my-2">查询参数</div>
              <div class="text-xs space-y-1">
                <div class="flex gap-2">
                  <code class="badge badge-ghost">ids</code>
                  <span class="text-base-content/60">源ID列表 (逗号分隔)</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">concurrency</code>
                  <span class="text-base-content/60">并发数限制</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">timeout</code>
                  <span class="text-base-content/60">超时时间(ms)</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- API 分类：系统监控 -->
      <div class="mb-8">
        <h3 class="text-xl font-bold mb-4 flex items-center gap-2">
          <span class="badge badge-secondary badge-outline">系统监控</span>
          System Monitoring
        </h3>
        <div class="grid grid-cols-1 xl:grid-cols-2 gap-4">
          <!-- /api/v1/health -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/health</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">系统健康检查和监控指标</p>

              <div class="divider my-2">功能说明</div>
              <ul class="text-xs text-base-content/70 space-y-1 list-disc list-inside">
                <li>系统运行状态（healthy/degraded/unhealthy）</li>
                <li>内存使用情况</li>
                <li>Node.js 版本和运行时间</li>
                <li>所有数据源的健康状态</li>
              </ul>

              <div class="divider my-2">请求示例</div>
              <div class="mock mock-code bg-base-300 text-xs">
                <pre>curl "https://your-site.com/api/v1/health"</pre>
              </div>
            </div>
          </div>

          <!-- /api/v1/metrics -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/metrics</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">获取系统性能指标</p>

              <div class="divider my-2">查询参数</div>
              <div class="text-xs space-y-1">
                <div class="flex gap-2">
                  <code class="badge badge-ghost">detailed</code>
                  <span class="text-base-content/60">是否返回详细指标</span>
                </div>
              </div>

              <div class="divider my-2">包含指标</div>
              <ul class="text-xs text-base-content/70 space-y-1 list-disc list-inside">
                <li>请求总数、错误率、平均响应时间</li>
                <li>缓存命中率</li>
                <li>P95/P99 响应时间</li>
                <li>各数据源成功率和耗时</li>
              </ul>
            </div>
          </div>

          <!-- /api/v1/errors -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/errors</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">获取错误统计信息</p>

              <div class="divider my-2">查询参数</div>
              <div class="text-xs space-y-1">
                <div class="flex gap-2">
                  <code class="badge badge-ghost">source</code>
                  <span class="text-base-content/60">按数据源筛选</span>
                </div>
              </div>
            </div>
          </div>

          <!-- /api/v1/logs -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/logs</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">查看系统日志</p>
            </div>
          </div>
        </div>
      </div>

      <!-- API 分类：高级功能 -->
      <div class="mb-8">
        <h3 class="text-xl font-bold mb-4 flex items-center gap-2">
          <span class="badge badge-accent badge-outline">高级功能</span>
          Advanced Features
        </h3>
        <div class="grid grid-cols-1 xl:grid-cols-2 gap-4">
          <!-- /api/v1/stream -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/stream</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">流式 API - 逐步返回数据</p>

              <div class="divider my-2">查询参数</div>
              <div class="text-xs space-y-1">
                <div class="flex gap-2">
                  <code class="badge badge-ghost">sources</code>
                  <span class="text-base-content/60">源ID列表 (必填)</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">chunkSize</code>
                  <span class="text-base-content/60">每批条目数</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">delay</code>
                  <span class="text-base-content/60">批次延迟(ms)</span>
                </div>
              </div>

              <div class="divider my-2">响应格式</div>
              <div class="mock mock-code bg-base-300 text-xs">
                <pre>{
  "type": "start|data|end|error",
  "sourceId": "weibo",
  "data": [...],
  "total": 20
}</pre>
              </div>
            </div>
          </div>

          <!-- /api/v1/optimized/batch -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/optimized/batch</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">优化批量 API（优先级队列）</p>

              <div class="divider my-2">查询参数</div>
              <div class="text-xs space-y-1">
                <div class="flex gap-2">
                  <code class="badge badge-ghost">sources</code>
                  <span class="text-base-content/60">源ID列表</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">priority</code>
                  <span class="text-base-content/60">优先级排序</span>
                </div>
                <div class="flex gap-2">
                  <code class="badge badge-ghost">concurrency</code>
                  <span class="text-base-content/60">并发数</span>
                </div>
              </div>
            </div>
          </div>

          <!-- /api/v1/security/ip-whitelist -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/v1/security/ip-whitelist</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">IP 白名单管理</p>
            </div>
          </div>

          <!-- /api/latest -->
          <div class="card bg-base-100 shadow-lg hover:shadow-xl transition-shadow">
            <div class="card-body">
              <div class="flex items-center gap-2 mb-2">
                <span class="badge badge-success">GET</span>
                <code class="text-sm font-mono font-bold">/api/latest</code>
              </div>
              <p class="text-sm text-base-content/70 mb-3">版本信息</p>
            </div>
          </div>
        </div>
      </div>

      <!-- 使用提示 -->
      <div class="card bg-base-100 shadow-xl mt-8">
        <div class="card-body">
          <h3 class="card-title text-lg">💡 使用提示</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4 text-sm">
            <div class="alert alert-info">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <span>所有 API 均支持 CORS，可直接在浏览器调用</span>
            </div>
            <div class="alert alert-success">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <span>数据自动缓存，使用 ?force=1 强制刷新</span>
            </div>
            <div class="alert alert-warning">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
              </svg>
              <span>部分源可能因反爬虫而失败，会自动重试</span>
            </div>
            <div class="alert alert-warning">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <span>建议设置 User-Agent 避免被限流</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 底部 -->
      <div class="text-center mt-12 mb-8 text-base-content/50 text-sm">
        <p>需要更多帮助？查看项目文档或联系开发者</p>
        <NuxtLink to="/" class="link link-hover mt-2 inline-block">← 返回首页</NuxtLink>
      </div>
    </main>
  </div>
</template>

<script setup>
useHead({
  title: 'API 文档 - 热榜聚合',
  meta: [
    {
      name: 'description',
      content: '热榜聚合 API 接口文档 - 查看所有可用的 API 端点和使用说明'
    }
  ]
})
</script>

<style scoped>
@reference "tailwindcss";

.mock-code {
  @apply p-3 rounded-lg overflow-x-auto;
}

.mock-code pre {
  @apply m-0 whitespace-pre-wrap break-words;
}

.card {
  @apply transition-all duration-200;
}

.card:hover {
  transform: translateY(-2px);
}
</style>
