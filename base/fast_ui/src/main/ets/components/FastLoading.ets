@Extend(Column)
function cardStyle() {
  .backgroundColor(0xB3000000)
  .alignItems(HorizontalAlign.Center)
  .justifyContent(FlexAlign.Center)
  .padding(10)
  .borderRadius(14)
  .shadow({
    radius: 14,
    type: ShadowType.BLUR,
  })
}

@Extend(Text)
function messageStyle(fontSize: number | Resource | string, fontWeight: number) {
  .fontSize(fontSize)
  .fontWeight(fontWeight)
}

@Component
export struct FastLoading {
  messageFontSize: number | Resource | string = 16
  messageFontWeight: number = 600
  message: string | Resource = $r('app.string.loading')

  build() {
    Row({ space: 3 }) {
      Text(this.message).messageStyle(this.messageFontSize, this.messageFontWeight)
      LoadingProgress()
        .width(40)
        .height(40)
        .color($r('app.color.secondary'))
    }
    .padding(10)
    .justifyContent(FlexAlign.Center)
  }
}

@CustomDialog
export struct FastLoadingDialog {
  private controller: CustomDialogController;

  build() {
    Column() {
      FastLoading()
    }.cardStyle()
  }
}

// dialog 的形式样式loading
// let LoadingDialog =  new CustomDialogController(
//   {
//     builder: FastLoadingDialog(),
//     alignment: DialogAlignment.Center,
//     customStyle: true,
//     maskColor: Color.Transparent,
//   }
// )
// loadingDialog.open()