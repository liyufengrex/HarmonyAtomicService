export class FastNavRouterModel {
  // 路由页面别名，形式为${包名}*${页面名}，例如：@ohos/feature_setting*./src/main/ets/TestDynamicNavPage
  builderName: string = "";
  // 传递的参数
  param?: object;
}

export class FastNavRouter {
  static builderMap: Map<string, WrappedBuilder<[object]>> = new Map<string, WrappedBuilder<[object]>>();
  static navPathStack: NavPathStack = new NavPathStack();

  // 注册页面组件到路由表，builderName是路由名字，builder参数是包裹了页面组件的WrappedBuilder对象
  public static registerBuilder(
    builderName: string,
    builder: WrappedBuilder<[object]>
  ): void {
    FastNavRouter.builderMap.set(builderName, builder);
  }

  // 获取路由表中指定的页面组件
  public static getBuilder(builderName: string): WrappedBuilder<[object]> {
    const builder = FastNavRouter.builderMap.get(builderName);
    if (!builder) {
      console.info('not found builder ' + builderName);
    }
    return builder as WrappedBuilder<[object]>;
  }

  public static async push(router: FastNavRouterModel): Promise<void> {
    const harName = router.builderName.split('*')[0];
    if (harName !== undefined) {
      // 动态导入页面所在 har 模块
      let ns: ESObject = await import(harName);
      await ns.harInit(router.builderName);
    } else {
      // 例如自己模块内的单文件 '../Calc'
      await import(router.builderName);
    }
    FastNavRouter.navPathStack.pushPath({
      name: router.builderName,
      param: router.param
    });
  }
}