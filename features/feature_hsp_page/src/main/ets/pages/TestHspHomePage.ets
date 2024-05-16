import { CommonFillButton } from '@ohos/fast_ui/Index'
import { FastRouter, RouterModel } from '@ohos/fast_util/Index'

@Entry
@Component
struct Index {
  routerParams?: RouterModel
  @State receiveParams: string = ''

  aboutToAppear(): void {
    this.routerParams = FastRouter.getRouterCurrentParams as RouterModel
    this.receiveParams = this.routerParams.params!.toString()
  }

  build() {
    Column({ space: '30vp' }) {
      Text(`接收到的入参：${this.receiveParams}`).fontSize('18vp')
      CommonFillButton({
        text: '关闭并返回结果',
        horizontalPadding: '40vp',
        verticalPadding: '10vp',
        event: () => {
          if (this.routerParams?.popCallback !== undefined) {
            this.routerParams.popCallback('我是回调的结果 6100 ')
          }
          FastRouter.pop()
        }
      })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}