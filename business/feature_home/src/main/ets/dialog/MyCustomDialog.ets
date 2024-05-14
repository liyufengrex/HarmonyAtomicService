//自定义弹窗的内容
import { CommonFillButton } from '@ohos/fast_ui/Index'

@CustomDialog
export struct MyCustomDialog {
  private controller: CustomDialogController
  //确定按钮回调
  confirmed: (message: string) => void = (_) => {
  }
  //提供给 dialogContainer 通知弹窗已关闭
  disappearCallback: () => void = () => {
  }

  aboutToDisappear(): void {
    this.disappearCallback()
  }

  build() {
    Column() {
      Text('这是一个自定义弹窗').margin({
        top: '30vp',
        bottom: '20vp',
      })
      CommonFillButton({
        text: '点击传递数据给调用方',
        horizontalPadding: '90vp',
        verticalPadding: '12vp',
        event: (): void => {
          this.controller.close()
          this.confirmed('你好，我是弹窗点击返回的内容')
        }
      })
    }
    .width("100%")
    .padding({
      bottom: '15vp',
      left: '10vp',
      right: '10vp',
    })
    .borderRadius({
      topLeft: '24vp',
      topRight: '24vp',
    })
    .backgroundColor(Color.White)
  }
}