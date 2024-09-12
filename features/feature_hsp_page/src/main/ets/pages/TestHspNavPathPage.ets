/// 测试 NavPath 跳转 HSP 内页面
/// 使用 NavPath 跳转 HSP 内页面，需要在 route_map.json 中进行声明，module.json5 内需要添加 "routerMap": "$profile:route_map"
import { CommonFillButton } from '@ohos/fast_ui'
import { RouterModel } from '@ohos/fast_util'

@Builder
export function TestHspNavPathPageBuilder() {
  TestHspNavPathPage()
}

@Component
struct TestHspNavPathPage {
  routerParams?: RouterModel
  @State pathStack: NavPathStack = new NavPathStack()
  @State receiveParams: string = ''
  @State resultData: string = ''

  aboutToAppear(): void {
    this.resultData = (Math.random() * 100).toFixed(0).toString()
  }

  build() {
    NavDestination() {
      Column({ space: '30vp' }) {
        Text(`页面模块及路径：feature_hsp_page(hsp) TestHspNavPathPage.ets`).fontSize('12vp').fontColor(Color.Red)
        Text(`接收到的入参：${this.receiveParams}`).fontSize('15vp')
        Text(`页面随机数（用于测试回传）: ${this.resultData}`).fontSize('18vp')
        CommonFillButton({
          text: '关闭并返回结果',
          horizontalPadding: '40vp',
          verticalPadding: '10vp',
          event: () => {
            if (this.routerParams?.popCallback !== undefined) {
              this.routerParams.popCallback(`Router 回调结果：${this.resultData}`)
            }
            this.pathStack.pop()
          }
        })
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('NavPath跳转HSP页面')
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
      this.routerParams = context.pathInfo.param as RouterModel
      this.receiveParams = this.routerParams.params as string
    })
  }
}