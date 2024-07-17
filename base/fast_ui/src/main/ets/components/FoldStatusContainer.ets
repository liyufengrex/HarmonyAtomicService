/// 响应折叠屏变化的父容器

@Component
export struct FoldStatusContainer {
  @StorageProp('foldStatusKey') isFold: boolean = false
  // 非折叠状态 UI 布局
  @BuilderParam unFoldBodyContainer: () => void = this.defaultContainer
  // 折叠状态 UI 布局
  @BuilderParam foldBodyContainer: () => void = this.defaultContainer

  @Builder
  defaultContainer() {
    Column()
  }

  build() {
    Stack() {
      if (this.isFold) {
        this.foldBodyContainer()
      } else {
        this.unFoldBodyContainer()
      }
    }
    .width('100%')
    .height('100%')
  }
}