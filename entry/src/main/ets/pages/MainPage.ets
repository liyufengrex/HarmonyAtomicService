import { FastNavRouter, RouterModel } from '@ohos/fast_util/Index'
import {
  BuilderNodeExample,
  CustomDialogExample,
  EventBusExample,
  FixFoldUiExample,
  HomePage,
  HttpRequestExample,
  PermissionExample,
  RouterCallbackExample,
  TestNavPathPage,
  ThrottleExample
} from '@ohos/feature_home/Index'
import { PagePathConstants } from '@ohos/global_constant/Index'
import { FoldStatusObserver } from '../entryability/FoldStatusObserver'

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
  @Provide('navPathStack') navPathStack: NavPathStack = FastNavRouter.navPathStack;
  @State currentTab: HomeTabItem = homeTabs[0];

  public readonly foldStatusKey = 'foldStatusKey'

  aboutToAppear(): void {
    FoldStatusObserver.startListening()
  }

  aboutToDisappear(): void {
    FoldStatusObserver.stopListening()
  }

  // 路由跳转控制
  @Builder
  PageMap(name: string, params?: RouterModel) {
    if (FastNavRouter.getBuilder(name) !== undefined) {
      // 测试动态路由 (TestDynamicNavPage)
      FastNavRouter.getBuilder(name).builder(params)
    } else {
      if (name === PagePathConstants.PAGE_HTTP_REQUEST) {
        HttpRequestExample()
      } else if (name === PagePathConstants.PAGE_EVENT_BUS) {
        EventBusExample()
      } else if (name === PagePathConstants.PAGE_CUSTOM_DIALOG) {
        CustomDialogExample()
      } else if (name === PagePathConstants.PAGE_ROUTER_CALLBACK) {
        RouterCallbackExample()
      } else if (name === PagePathConstants.PAGE_NAV_ROUTER_TEST) {
        TestNavPathPage({
          routerParams: params
        })
      } else if (name === PagePathConstants.PAGE_THROTTLE_TEST) {
        ThrottleExample()
      } else if (name === PagePathConstants.PAGE_PERMISSION_TEST) {
        PermissionExample()
      } else if (name === PagePathConstants.DYNAMIC_UI_NODE_TEST) {
        BuilderNodeExample()
      } else if (name === PagePathConstants.FIX_FOLD_UI_EXAMPLE) {
        FixFoldUiExample()
      } else {
        NavDestination() {
          Text('other')
        }
        .title('other')
      }
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
              Text()
            }
          }
          .tabBar(
            this.TabBuilder(item)
          )
        })
      }
      .scrollable(false)
      .animationDuration(0)
      .barHeight('48vp')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
      .onChange((index) => {
        this.currentTab = homeTabs[index]
      })
    }
    .mode(NavigationMode.Stack) //不加这个在折叠屏会有问题
    .navBarWidth('100%')
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.primary'))
    .navDestination(this.PageMap)
    .appStyle()
  }
}
