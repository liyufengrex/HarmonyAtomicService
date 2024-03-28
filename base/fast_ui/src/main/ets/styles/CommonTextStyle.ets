/// 统一样式的 Text

interface CommonTextOption {
  fontColor?: string | Resource;
  fontSize?: number | Resource | string;
  fontWeight?: number | FontWeight;
  lineHeight?: number | string | Resource;
  textAlign?: TextAlign
  overflow?: TextOverflow
  maxLines?: number
  text: string | Resource;
}

@Builder
function CommonMainTitle(
  option: CommonTextOption
) {
  Text(option.text)
    .fontSize(option.fontSize ?? $r('app.float.font_title'))
    .fontColor(option.fontColor ?? $r('app.color.text_main'))
    .fontWeight(option.fontWeight ?? FontWeight.Medium)
    .lineHeight(option.lineHeight)
    .textAlign(option.textAlign)
    .maxLines(option.maxLines)
    .textOverflow({ overflow: option.overflow ?? TextOverflow.None })
}

@Builder
function CommonSubTitle(
  option: CommonTextOption
) {
  Text(option.text)
    .fontSize(option.fontSize ?? $r('app.float.font_sub_title'))
    .fontColor(option.fontColor ?? $r('app.color.text_sub'))
    .fontWeight(option.fontWeight ?? FontWeight.Normal)
    .lineHeight(option.lineHeight)
    .textAlign(option.textAlign)
    .maxLines(option.maxLines)
    .textOverflow({ overflow: option.overflow ?? TextOverflow.None })
}

export { CommonMainTitle, CommonSubTitle }

/// 使用方式预览
@Entry
@Component
struct PreviewTest {
  build() {
    Column({ space: 20 }) {
      CommonMainTitle({
        text: 'MainTitle',
      })
      CommonSubTitle({
        text: 'SubTitle'
      })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}