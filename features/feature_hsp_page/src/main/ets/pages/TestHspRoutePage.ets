import { CommonFillButton } from '@ohos/fast_ui/Index'
import { FastRouter, RouterModel } from '@ohos/fast_util/Index'

/// 测试 Route 跳转 HSP 内页面
@Entry
@Component
struct TestHspRoutePage {
  routerParams?: RouterModel
  @State receiveParams: string = ''
  @State resultData: string = ''

  aboutToAppear(): void {
    this.routerParams = FastRouter.getRouterCurrentParams as RouterModel
    this.receiveParams = this.routerParams.params!.toString()
    this.resultData = (Math.random() * 100).toFixed(0).toString()
  }

  onBackPress(): boolean | void {
    FastRouter.pop()
    return true
  }

  build() {
    NavDestination() {
      Column({ space: '30vp' }) {
        Text(`页面模块及路径：feature_hsp_page(hsp) TestHspRoutePage.ets`).fontSize('12vp').fontColor(Color.Red)
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
            FastRouter.pop()
          }
        })
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('Route跳转HSP页面')
  }
}