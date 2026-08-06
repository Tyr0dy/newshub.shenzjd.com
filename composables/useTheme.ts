import { ref } from "vue";

/**
 * 主题管理（data-theme 驱动）
 * - daisyUI 主题 + Tailwind dark: 变体均跟随 html[data-theme]
 * - 单一状态源，避免 app.vue 与 NewHeader 各自维护 ref 导致状态不同步
 * - 首屏初始化由 app.vue 的 head 内联脚本完成（防闪烁），这里只做状态同步
 */
const isDark = ref(false);

export function useTheme() {
  const apply = (dark: boolean) => {
    isDark.value = dark;
    document.documentElement.setAttribute("data-theme", dark ? "dark" : "light");
    localStorage.setItem("theme", dark ? "dark" : "light");
  };

  const toggle = () => apply(!isDark.value);

  // 客户端同步当前主题（读取 html[data-theme]，与 head 内联脚本一致）
  const sync = () => {
    isDark.value = document.documentElement.getAttribute("data-theme") === "dark";
  };

  return { isDark, toggle, sync };
}
