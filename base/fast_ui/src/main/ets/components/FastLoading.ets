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
function messageStyle(
  fontSize: number | Resource | string,
  fontWeight: number | FontWeight | string
) {
  .fontSize(fontSize)
  .fontWeight(fontWeight)
}

@Component
export struct FastLoading {
  loadingSize: Length = '40vp'
  messageFontSize: number | Resource | string = '16fp'
  messageFontWeight: number | FontWeight | string = FontWeight.Medium
  message: string | Resource | null = $r('app.string.loading')

  build() {
    Row({ space: 3 }) {
      Text(this.message)
        .messageStyle(
          this.messageFontSize,
          this.messageFontWeight
        )
        .visibility(this.message != null ? Visibility.Visible : Visibility.None)
      LoadingProgress()
        .width(this.loadingSize)
        .height(this.loadingSize)
        .color($r('app.color.secondary'))
    }
    .padding('10vp')
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