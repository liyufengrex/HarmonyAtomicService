import { FillFlexButton } from '@ohos/fast_ui/src/main/ets/styles/CommonButtonStyle';
import { FastRouter, RouterModel } from '@ohos/fast_util/Index';
import { PagePathConstants } from '@ohos/global_constant/Index';

/// 两种路由方式跳转HSP回调示例
@Component
export struct RouterCallbackExample {
  @Consume('navPathStack') navPathStack: NavPathStack;
  @State receiveData: string = ''
  params1: string = '112233'
  params2: string = '223344'

  // navPath 方式跳转 hsp 并获取回调， 对应页面为 -> TestHspNavPathPage
  navPathJumpHsp() {
    const routerParams: RouterModel = {
      params: this.params1,
      popCallback: (callbackValue) => {
        if (callbackValue !== undefined) {
          this.receiveData = callbackValue.toString()
        }
      }
    }
    this.navPathStack.pushPathByName('TestHspNavJumpCallback', routerParams)
  }

  // navPath 方式跳转 har 并获取回调， 对应页面为 -> TestHspNavPathPage
  navPathJumpHar() {
    const routerParams: RouterModel = {
      params: this.params1,
      popCallback: (callbackValue) => {
        if (callbackValue !== undefined) {
          this.receiveData = callbackValue.toString()
        }
      }
    }
    this.navPathStack.pushPathByName(PagePathConstants.PAGE_NAV_ROUTER_TEST, routerParams)
  }

  // router 跳转 hsp 并获取回调
  routerJump() {
    const routerParams: RouterModel = {
      url: '@bundle:com.atomicservice.5765880207855149405/feature_hsp_page/ets/pages/TestHspRoutePage',
      params: this.params2,
      popCallback: (callbackValue) => {
        if (callbackValue !== undefined) {
          this.receiveData = callbackValue.toString()
        }
      }
    }
    FastRouter.push(routerParams)
  }

  @Builder
  pageCallbackResult() {
    Text(this.receiveData)
      .fontSize('17vp')
      .fontColor(Color.Red)
      .height('20%')
  }

  @Builder
  navPathJumpItems() {
    Column() {
      Text('1.使用 NavPathStack 方式跳转')
        .fontWeight(FontWeight.Medium)
        .fontSize('20')
        .margin({
          bottom: 5
        })

      Text(`传递入参：${this.params1}`)
        .fontSize('15vp')
        .margin({
          bottom: '10vp'
        })

      jumpWidget(
        '跳转 har 页面并回调',
        this.params1,
        () => {
          this.navPathJumpHar()
        }
      )

      jumpWidget(
        '跳转 hsp 页面并回调',
        this.params1,
        () => {
          this.navPathJumpHsp()
        }
      )
    }
    .height('50%')
  }

  @Builder
  routeJumpItems() {
    Column() {
      Text('2.使用 Route 方式跳转')
        .fontWeight(FontWeight.Medium)
        .fontSize('20')
        .margin({
          bottom: 5
        })

      Text(`传递入参：${this.params2}`)
        .fontSize('15vp')
        .margin({
          bottom: '10vp'
        })

      jumpWidget(
        '跳转 hsp 页面并回调',
        this.params2,
        () => {
          this.routerJump()
        }
      )
    }
    .height('30%')
  }

  build() {
    NavDestination() {
      Column() {
        this.pageCallbackResult()
        this.navPathJumpItems()
        this.routeJumpItems()
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('页面跳转回调示例')
  }
}

@Builder
function jumpWidget(
  jumpTitle: string,
  params: Object,
  jumpFunc: () => void,
) {
  Column() {
    Row() {
      FillFlexButton({
        text: jumpTitle,
        verticalPadding: 10,
        event: () => {
          jumpFunc()
        }
      })
    }
    .height(60)
    .width('80%')
  }
  .width('100%')
  .alignItems(HorizontalAlign.Center)
}