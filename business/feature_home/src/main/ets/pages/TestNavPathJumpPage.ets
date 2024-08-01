import { CommonFillButton } from '@ohos/fast_ui/src/main/ets/styles/CommonButtonStyle';
import { RouterModel } from '@ohos/fast_util/src/main/ets/FastRouter';

/// 测试 NavPathStack 跳转的页面
@Component
export struct TestNavPathJumpPage {
  @Consume('navPathStack') navPathStack: NavPathStack;
  routerParams?: RouterModel
  @State receiveParams: string = ''
  @State resultData: string = ''

  aboutToAppear(): void {
    this.receiveParams = this.routerParams!.params!.toString()
    this.resultData = (Math.random() * 100).toFixed(0).toString()
  }

  build() {
    NavDestination() {
      Column({ space: '30vp' }) {
        Text(`接收到的入参：${this.receiveParams}`).fontSize('15vp')
        Text(`页面随机数（用于测试回传）: ${this.resultData}`).fontSize('18vp')
        CommonFillButton({
          text: '关闭并返回结果',
          horizontalPadding: '40vp',
          verticalPadding: '10vp',
          event: () => {
            if (this.routerParams?.popCallback !== undefined) {
              this.routerParams.popCallback(`NavPathStack 回调结果：${this.resultData}`)
            }
            this.navPathStack.pop()
          }
        })
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('NavPathStack 跳转目标页')
  }
}