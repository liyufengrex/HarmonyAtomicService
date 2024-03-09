/// 统一的按钮样式
interface CommonButtonOption {
  backGroundColor?: Resource;
  borderColor?: Resource;
  fontColor?: Resource;
  fontSize?: number | Resource;
  fontWeight?: number | FontWeight;
  text: string | Resource;
  event: () => void;
}

// 颜色填充的样式按钮
@Builder
function CommonFillButton(
  option: CommonButtonOption
) {
  Button(option.text,
    {
      type: ButtonType.Normal,
      stateEffect: true
    })
    .fontColor(option.fontColor ?? $r('app.color.primary'))
    .fontWeight(option.fontWeight ?? FontWeight.Normal)
    .fontSize(option.fontSize ?? $r('app.float.font_default'))
    .backgroundColor(option.backGroundColor ?? $r('app.color.secondary'))
    .padding({
      left: 18,
      top: 6,
      right: 18,
      bottom: 6
    })
    .borderRadius('3vp')
    .onClick(option.event)
}

// 边框线样式的按钮
@Builder
function CommonLineButton(
  option: CommonButtonOption
) {
  Button(option.text,
    {
      type: ButtonType.Normal,
      stateEffect: true
    })
    .fontColor(option.fontColor ?? $r('app.color.text_button_2'))
    .fontWeight(option.fontWeight ?? FontWeight.Normal)
    .fontSize(option.fontSize ?? $r('app.float.font_default'))
    .backgroundColor(option.backGroundColor ?? $r('app.color.primary'))
    .borderColor(option.borderColor ?? $r('app.color.border_color'))
    .borderWidth(1)
    .padding({
      left: 18,
      top: 6,
      right: 18,
      bottom: 6
    })
    .borderRadius('3vp')
    .onClick(option.event)
}

export { CommonFillButton, CommonLineButton }


/// 使用方式预览
@Entry
@Component
struct PreviewTest {
  build() {
    Column({ space: 20 }) {
      CommonFillButton({
        text: "abc",
        event: () => {

        }
      })
      CommonLineButton({
        text: "abc",
        event: () => {

        }
      })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

