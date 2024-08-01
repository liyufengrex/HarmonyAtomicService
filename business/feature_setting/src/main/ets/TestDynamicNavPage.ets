// 测试动态路由
import { FastNavRouter } from '@ohos/fast_util';
import { PagePathConstants } from '@ohos/global_constant';

@Component
export struct TestDynamicNavPage {
  params?: object

  build() {
    NavDestination() {
      Column({ space: '30vp' }) {
        Text('页面路径：TestDynamicNavPage').fontSize('18vp').fontWeight(FontWeight.Bold)
        Text(`${this.params}`).fontSize('12vp')
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
    }
    .title('动态路由目标页')
  }
}

@Builder
export function TestDynamicNavPageBuilder(params: object) {
  TestDynamicNavPage({
    params: params
  })
}

// 在页面首次加载时触发执行
const builderName: string = PagePathConstants.DYNAMIC_ROUTER_TEST;
// 判断表中是否已存在路由信息，避免重复注册
if (!FastNavRouter.getBuilder(builderName)) {
  // 通过系统提供的wrapBuilder接口封装@Builder装饰的方法
  let builder: WrappedBuilder<[object]> = wrapBuilder(TestDynamicNavPageBuilder);
  // 注册页面到全局路由表
  FastNavRouter.registerBuilder(builderName, builder);
}

