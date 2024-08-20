import { PagePathConstants } from '@ohos/global_constant';

export { SettingPage } from './src/main/ets/pages/SettingPage'

export function harInit(name: string): void {
  // 根据routerModule中路由表的key值动态加载要跳转的页面的相对路径
  switch (name) {
    case PagePathConstants.DYNAMIC_ROUTER_TEST:
      import("./src/main/ets/pages/TestDynamicNavPage");
      break;
    default:
      break;
  }
}