/// 组件工厂示例
@Builder
function UI1(text: string) {
  Text(text).fontColor(Color.Green)
}

@Builder
function UI2(text: string) {
  Text(text).fontColor(Color.Blue)
}

let factoryMap: Map<string, object> = new Map();

factoryMap.set('UI1', wrapBuilder(UI1))
factoryMap.set('UI2', wrapBuilder(UI2))

@Component
struct TestComponentFactory {
  build() {
    Column({ space: 10 }) {
      (factoryMap.get('UI1') as WrappedBuilder<[string]>).builder('工厂组件 - 1');
      (factoryMap.get('UI2') as WrappedBuilder<[string]>).builder('工厂组件 - 2');
    }
  }
}

@Component
export struct ComponentFactoryExample {
  build() {
    NavDestination() {
      Row() {
        Column() {
          TestComponentFactory()
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .height('100%')
      .alignItems(VerticalAlign.Center)
    }.title('组件工厂示例')
  }
}