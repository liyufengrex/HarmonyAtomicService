import { HomePage, HttpRequestExample } from '@ohos/feature_home/Index'
import { PagePathConstants } from '@ohos/global_constant/Index'

enum TabItemEnum {
  home = '首页',
  setting = '设置',
}

interface HomeTabItem {
  type: TabItemEnum
  img: Resource
  selectImg: Resource
}

const homeTabs: HomeTabItem[] = [
  {
    type: TabItemEnum.home,
    img: $r('app.media.ic_home_normal'),
    selectImg: $r('app.media.ic_home_select'),
  },
  {
    type: TabItemEnum.setting,
    img: $r('app.media.ic_mine_normal'),
    selectImg: $r('app.media.ic_mine_select'),
  },
]

@Extend(Navigation)
function appStyle() {
  .hideTitleBar(true)
}

@Extend(Image)
function tabIconStyle() {
  .objectFit(ImageFit.Contain)
  .width('24vp')
  .height('24vp')
}

@Extend(Text)
function tabLabelStyle() {
  .fontColor(0x4A4A4A)
  .fontSize('12fp')
  .textAlign(TextAlign.Center)
}

@Entry
@Component
struct MainPage {

  @Provide('navPathStack') navPathStack: NavPathStack = new NavPathStack();
  @State currentTab: HomeTabItem = homeTabs[0];

  @Builder
  PageMap(name: string) {
    if (name === PagePathConstants.PAGE_HTTP_REQUEST) {
      HttpRequestExample()
    } else {
      Text('other')
    }
  }

  @Builder
  TabBuilder(tabItem: HomeTabItem) {
    Column() {
      Image(tabItem.type === this.currentTab.type ? tabItem.selectImg : tabItem.img)
        .tabIconStyle()
      Text(tabItem.type.toString())
        .tabLabelStyle()
    }
    .size({ width: '100%', height: '100%' })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Navigation(this.navPathStack) {
      Tabs({
        barPosition: BarPosition.End,
      }) {
        ForEach(
          homeTabs, (item: HomeTabItem, index) => {
          TabContent() {
            if (this.currentTab.type == TabItemEnum.home) {
              HomePage()
            } else {
              Text(index.toString())
            }
          }
          .tabBar(
            this.TabBuilder(item)
          )
        })
      }
      .barHeight('48vp')
      .onChange((index) => {
        this.currentTab = homeTabs[index]
      })
    }
    .backgroundColor($r('app.color.primary'))
    .navDestination(this.PageMap)
    .appStyle()
  }
}
