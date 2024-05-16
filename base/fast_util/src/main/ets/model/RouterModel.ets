export interface RouterModel {
  // 页面路径
  // 例如 ： 1. 本地包内，或者直接依赖的静态包内页面 ： pages/Page1
  //        2. 分包内的页面 ：@bundle:com.rex.harmony.atomic.service/featureName/ets/pages/Page2
  url?: string
  params?: Object, // 要传递给跳转页面的参数
  popCallback?: (value: Object | undefined) => void // 用于页面回调
}

