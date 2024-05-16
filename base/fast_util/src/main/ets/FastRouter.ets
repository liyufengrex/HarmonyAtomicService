import { RouterModel } from './model/RouterModel'
import { router } from '@kit.ArkUI'

/// 基于 router 库封装，为了实现页面回调
export class FastRouter {
  public readonly routerStack: RouterModel[] = []

  /// 跨 hsp 使用这种方式实现单例
  public static instance(): FastRouter {
    const storageKey = 'REX_FAST_ROUTER'
    if (!AppStorage.has(storageKey)) {
      AppStorage.setOrCreate(storageKey, new FastRouter())
    }
    return AppStorage.get<FastRouter>(storageKey)!
  }

  /// 获取路由传递的入参
  public static get getRouterCurrentParams(): RouterModel | undefined {
    const stack = FastRouter.instance().routerStack
    if (stack.length === 0) {
      return undefined
    }
    return stack[stack.length - 1]
  }

  /// push 页面
  public static async push(route: RouterModel): Promise<void> {
    try {
      await router.pushUrl({ url: route.url, params: route.params })
      FastRouter.instance().routerStack.push(route)
    } catch (_) {
      console.log('>>>>')
    }
  }

  /// replace 页面
  public static async replace(route: RouterModel): Promise<void> {
    try {
      await router.replaceUrl({ url: route.url, params: route.params })
      const instance = FastRouter.instance()
      const list = instance.routerStack
      if (list.length > 0) {
        instance.routerStack.splice(instance.routerStack.length - 1, 1, route)
      }
    } catch (_) {
      // 暂无处理
    }
  }

  /// 退出栈顶页面
  public static async pop(animated?: boolean): Promise<void> {
    router.back()
    const routerStack = FastRouter.instance().routerStack
    routerStack.pop()
  }
}