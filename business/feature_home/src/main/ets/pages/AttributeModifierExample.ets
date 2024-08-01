/// 组件动态属性示例

class CusButtonModifier implements AttributeModifier<ButtonAttribute> {
  private buttonType: ButtonType = ButtonType.Normal;

  applyNormalAttribute(instance: ButtonAttribute): void {
    instance.stateEffect(true)
    instance.type(this.buttonType)
    instance.height(50)
    instance.fontSize(20)
  }

  toggleType(): CusButtonModifier {
    if (this.buttonType === ButtonType.Normal) {
      this.buttonType = ButtonType.Capsule
    } else {
      this.buttonType = ButtonType.Normal
    }
    return this;
  }
}

@Component
export struct AttributeModifierExample {
  @State modifier: CusButtonModifier = new CusButtonModifier();

  build() {
    NavDestination() {
      Column() {
        Button('Test AttributeModifier Button')
          .attributeModifier(this.modifier)
          .onClick(() => {
            this.modifier.toggleType()
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('组件动态属性设置示例')
  }
}