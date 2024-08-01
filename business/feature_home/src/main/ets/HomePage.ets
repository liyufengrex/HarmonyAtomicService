/// 首页
import { FastNavRouter } from '@ohos/fast_util';
import { PagePathConstants } from '@ohos/global_constant';
import { Category, SubCategory, HOME_CATEGORIES } from './config/HomeCategoricalData';


@Extend(Column)
function ColumnStyle() {
  .width('100%')
  .borderRadius(24)
  .backgroundColor(Color.White)
  .padding({
    left: 12,
    right: 12,
    bottom: 4,
    top: 4
  })
}

@Extend(Text)
function TitleStyle() {
  .height(48)
  .fontSize(14)
  .width('100%')
  .textAlign(TextAlign.Start)
  .fontFamily('HarmonyHeiTi-Medium')
  .fontColor($r('app.color.font_color_shallow'))
  .padding({ bottom: 4, top: 4, left: 24 })
}

@Component
export struct HomePage {
  build() {
    Column() {
      List() {
        ForEach(HOME_CATEGORIES, (category: Category, index: number) => {
          CategoryItem({ category: category })
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 4 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding({ top: 12 })
  }
}

@Component
struct CategoryItem {
  private category: Category | null = null

  build() {
    ListItem() {
      Column() {
        Text(this.category!.title).TitleStyle()
        Column() {
          ForEach(
            this.category!.childNodes,
            (subItem: SubCategory, index: number) => {
              SubCategoryItem({ subItem: subItem })
            }
          )
        }.ColumnStyle()
      }
    }
  }
}

@Component
struct SubCategoryItem {
  @Consume('navPathStack') navPathStack: NavPathStack;
  private subItem: SubCategory | null = null

  build() {
    Row() {
      if (this.subItem) {
        Text(this.subItem.title)
          .fontSize(16)
          .layoutWeight(1)
          .margin({ left: 42 })
          .align(Alignment.Start)
          .fontFamily('HarmonyHeiTi-Medium')
          .fontColor(Color.Black)
      }
      Blank()
    }
    .height(48)
    .width('100%')
    .onClick(() => {
      if (this.subItem?.url === PagePathConstants.DYNAMIC_ROUTER_TEST) {
        // 测试动态路由
        let param = new String(this.subItem.url)
        FastNavRouter.push({ builderName: this.subItem.url, param: param })
      } else {
        this.navPathStack.pushPathByName(this.subItem?.url ?? '', null)
      }
    })
  }
}
