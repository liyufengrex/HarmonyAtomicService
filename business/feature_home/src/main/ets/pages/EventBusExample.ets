// EventBus 示例
import { CommonFillButton } from '@ohos/fast_ui/Index'
import { EventBus } from '@ohos/fast_util/Index'

@Styles
function SizeStyle() {
  .width('100%')
  .height('100%')
}

@Component
export struct EventBusExample {
  build() {
    NavDestination() {
      Column() {
        PageA().height('50%')
        PageB().height('50%')
      }
      .SizeStyle()
    }
    .title('事件通知示例')
  }
}

@Component
struct PageA {
  @State receivedData: string = ''

  aboutToAppear(): void {
    EventBus.listen<TestEventModule>('TestEventID', (data) => {
      if (data !== undefined) {
        this.receivedData = JSON.stringify(data)
      }
    })
  }

  build() {
    Column({space: '15vp'}) {
      Text('PageA')
      Text(this.receivedData)
    }
    .justifyContent(FlexAlign.Center)
    .SizeStyle()
  }
}

@Component
struct PageB {
  build() {
    Column({space: '15vp'}) {
      Text('PageB')
      CommonFillButton({
        text: '发送消息给注册方',
        event: () => {
          let eventData: TestEventModule = {
            name: '李小轰',
            age: 123
          }
          EventBus.send('TestEventID', eventData)
        }
      })
    }
    .justifyContent(FlexAlign.Center)
    .SizeStyle()
    .backgroundColor(Color.Yellow)
  }
}

// test: eventBus 发送和接收的数据模型
interface TestEventModule {
  name: string,
  age: number,
}