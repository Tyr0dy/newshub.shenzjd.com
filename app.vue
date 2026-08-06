<template>
  <div
    class="min-h-screen bg-gradient-to-br from-base-100 via-base-50 to-base-100 dark:from-base-200 dark:via-base-300 dark:to-base-200">
    <!-- 主要内容区域 -->
    <main class="relative">
      <NuxtPage />
    </main>

    <!-- 回到顶部按钮 -->
    <button
      @click="scrollToTop"
      class="fixed bottom-6 right-6 btn btn-circle btn-primary shadow-lg opacity-0 transition-opacity duration-300"
      :class="{ 'opacity-100': showScrollTop }"
      id="scrollToTopBtn">
      <svg
        class="w-5 h-5"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24">
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          stroke-width="2"
          d="M5 10l7-7m0 0l7 7m-7-7v18" />
      </svg>
    </button>
  </div>
</template>

<script setup>
import { useTheme } from "~/composables/useTheme";

// 版本信息
const version = "1.0.0";

// 主题管理：head 内联脚本在首屏渲染前同步设置 data-theme（防闪烁），
// 后续切换由 NewHeader 调用 useTheme().toggle() 完成
useHead({
  script: [
    {
      innerHTML: `(function(){try{var t=localStorage.getItem("theme");var d=t?t==="dark":window.matchMedia("(prefers-color-scheme: dark)").matches;document.documentElement.setAttribute("data-theme",d?"dark":"light")}catch(e){document.documentElement.setAttribute("data-theme","light")}})();`,
    },
  ],
});

const { sync } = useTheme();
if (import.meta.client) {
  sync();
}

// 回到顶部功能
const showScrollTop = ref(false);
const toggleScrollTop = () => {
  showScrollTop.value = window.scrollY > 300;
};

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: "smooth" });
};

onMounted(() => {
  window.addEventListener("scroll", toggleScrollTop);
  toggleScrollTop(); // 初始化检查
});

onUnmounted(() => {
  window.removeEventListener("scroll", toggleScrollTop);
});
</script>

<style scoped>
/* 自定义滚动条样式 */
.scrollbar-thin {
  scrollbar-width: thin;
}

.scrollbar-thin::-webkit-scrollbar {
  width: 4px;
}

.scrollbar-thin::-webkit-scrollbar-track {
  background: transparent;
}

.scrollbar-thin::-webkit-scrollbar-thumb {
  background: rgb(203 213 225 / 0.3);
  border-radius: 2px;
}

.scrollbar-thin::-webkit-scrollbar-thumb:hover {
  background: rgb(203 213 225 / 0.5);
}
</style>
