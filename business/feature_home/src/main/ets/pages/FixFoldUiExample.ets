import { FoldStatusContainer } from '@ohos/fast_ui'

// 适配折叠屏
@Component
export struct FixFoldUiExample {

  @Builder
  unFoldUiContainer() {
    Stack() {
      Text('我是全屏内容').fontSize(20)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Orange)
  }

  @Builder
  foldUiContainer() {
    Row() {
      Stack() {
        Text('我是左边的分屏内容').fontSize(20)
      }
      .backgroundColor(Color.Grey)
      .height('100%')
      .layoutWeight(1)

      Stack() {
        Text('我是右边的分屏内容').fontSize(20)
      }
      .backgroundColor(Color.Pink)
      .height('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  bodyContainer() {
    FoldStatusContainer({
      unFoldBodyContainer: this.unFoldUiContainer,
      foldBodyContainer: this.foldUiContainer,
    })
  }

  build() {
    NavDestination() {
      Column() {
        this.bodyContainer()
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }.title('适配折叠屏')
  }
}