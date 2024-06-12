/// UI动态节点示例
import { BuilderNode, FrameNode, NodeController } from '@kit.ArkUI'

// 1. 准备好需要挂载的节点及要绑定的数据模型
class Params {
  text: string = ''

  constructor(text: string) {
    this.text = text
  }
}

@Builder
function customNodeBuilder(params: Params) {
  Column() {
    Text(params.text)
      .fontSize(25)
      .margin({ bottom: 15 })
  }
}

// 2. 封装 controller 用于实现自定义节点的创建、显示、更新等操作
class CustomNodeController extends NodeController {
  private customNode: BuilderNode<[Params]> | null = null;
  private message: string = "";

  constructor(message: string) {
    super()
    this.message = message
  }

  makeNode(context: UIContext): FrameNode | null {
    this.customNode = new BuilderNode(context);
    this.customNode.build(wrapBuilder<[Params]>(customNodeBuilder), new Params(this.message))
    return this.customNode.getFrameNode();
  }

  update(message: string) {
    if (this.customNode !== null) {
      this.customNode.update(new Params(message));
    }
  }
}

// 3. 使用自定义节点
@Component
export struct BuilderNodeExample {
  private textNodeController: CustomNodeController = new CustomNodeController('hello');
  private count = 0;

  build() {
    NavDestination() {
      Row() {
        Column() {
          NodeContainer(this.textNodeController)
            .width('100%')
            .height(100)
            .align(Alignment.Center)
          Button('Update')
            .onClick(() => {
              this.count += 1;
              this.textNodeController.update("Update " + this.count.toString());
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .height('100%')
      .alignItems(VerticalAlign.Center)
    }.title('UI动态节点示例')
  }
}