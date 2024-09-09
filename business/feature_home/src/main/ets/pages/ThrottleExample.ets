// 节流防抖 示例
import { CommonFillButton } from '@ohos/fast_ui/Index'
import { FastLog, Throttle } from '@ohos/fast_util/Index'

@Component
export struct ThrottleExample {
  @State count: number = 0

  @Builder
  testThrottleButton() {
    CommonFillButton({
      text: '点击+1',
      event: () => {
        this.onClickTap('rex')
      }
    })
  }

  @Throttle(2000)
  onClickTap(name: string) {
    FastLog.log(name)
    this.count++
  }

  build() {
    NavDestination() {
      Column({ space: '15vp' }) {
        Text('设置节流时间为 2 秒')
        Text(this.count.toString())
          .fontSize('20vp')
        this.testThrottleButton()
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
    }
    .title('节流防抖示例')
  }
}