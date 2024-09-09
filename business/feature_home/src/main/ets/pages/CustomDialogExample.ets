import { CommonFillButton } from '@ohos/fast_ui/Index'
import { CustomDialogContainer, DialogContainerController } from '../dialog/CustomDialogContainer'

@Component
export struct CustomDialogExample {
  @State callbackMessage: string = ''
  @State dialogController: DialogContainerController = new DialogContainerController(
    (message: string | undefined) => {
      // 这里接收到弹窗内确定按钮点击返回的数据
      if (message != undefined) {
        this.callbackMessage = message
      }
    }
  )

  // 如果有多个样式的弹窗，定义多个 dialogController 然后统一在这里管理
  @Builder
  DialogControllerBuilder() {
    Column() {
      CustomDialogContainer({
        controller: this.dialogController
      })
    }
  }

  build() {
    NavDestination() {
      Column() {
        Text(this.callbackMessage)
          .textAlign(TextAlign.Center)
          .fontSize('18vp')
          .margin({
            bottom: '20vp',
          })
        this.DialogControllerBuilder()
        CommonFillButton({
          text: '弹窗',
          horizontalPadding: '40vp',
          verticalPadding: '10vp',
          event: () => {
            this.dialogController.open()
          }
        })
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }.title('自定义弹窗示例')
  }
}