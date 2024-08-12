/// 统一的按钮样式
interface CommonButtonOption {
  backGroundColor?: Resource;
  borderColor?: Resource;
  fontColor?: Resource;
  fontSize?: number | Resource;
  fontWeight?: number | FontWeight;
  horizontalPadding?: number | Resource | string;
  verticalPadding?: number | Resource | string;
  marginLeft?: number | Resource | string;
  marginTop?: number | Resource | string;
  marginRight?: number | Resource | string;
  marginBottom?: number | Resource | string;
  borderRadius?: number | Resource | string;
  text: string | Resource;
  event: () => void;
}

// 颜色填充的样式按钮
@Builder
function CommonFillButton(
  option: CommonButtonOption
) {
  Text(option.text)
    .fontSize(option.fontSize ?? $r('app.float.font_default'))
    .fontWeight(option.fontWeight ?? FontWeight.Normal)
    .fontColor(option.fontColor ?? $r('app.color.primary'))
    .backgroundColor(option.backGroundColor ?? $r('app.color.secondary'))
    .padding({
      left: option.horizontalPadding ?? '11vp',
      top: option.verticalPadding ?? '6vp',
      right: option.horizontalPadding ?? '11vp',
      bottom: option.verticalPadding ?? '6vp',
    })
    .margin(
      {
        left: option.marginLeft,
        top: option.marginTop,
        right: option.marginRight,
        bottom: option.marginBottom,
      }
    )
    .borderRadius(option.borderRadius ?? '5vp')
    .onClick(option.event)
}

// 边框线样式的按钮
@Builder
function CommonLineButton(
  option: CommonButtonOption
) {
  Text(option.text)
    .fontColor(option.fontColor ?? $r('app.color.text_button_2'))
    .fontWeight(option.fontWeight ?? FontWeight.Normal)
    .fontSize(option.fontSize ?? $r('app.float.font_default'))
    .backgroundColor(option.backGroundColor ?? $r('app.color.primary'))
    .borderColor(option.borderColor ?? $r('app.color.border_color'))
    .borderWidth(1)
    .padding({
      left: option.horizontalPadding ?? '11vp',
      top: option.verticalPadding ?? '6vp',
      right: option.horizontalPadding ?? '11vp',
      bottom: option.verticalPadding ?? '6vp',
    })
    .borderRadius(option.borderRadius ?? '5vp')
    .onClick(option.event)
}

@Builder
function FillFlexButton(
  option: CommonButtonOption
) {
  Text(option.text)
    .textAlign(TextAlign.Center)
    .fontSize(option.fontSize ?? $r('app.float.font_default'))
    .fontWeight(option.fontWeight ?? FontWeight.Normal)
    .fontColor(option.fontColor ?? $r('app.color.primary'))
    .backgroundColor(option.backGroundColor ?? $r('app.color.secondary'))
    .padding({
      top: option.verticalPadding ?? '6vp',
      bottom: option.verticalPadding ?? '6vp',
    })
    .margin(
      {
        left: option.marginLeft,
        top: option.marginTop,
        right: option.marginRight,
        bottom: option.marginBottom,
      }
    )
    .borderRadius(option.borderRadius ?? '24vp')
    .width('100%')
    .layoutWeight(1)
    .onClick(option.event)
}

export { CommonFillButton, CommonLineButton, FillFlexButton }


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

