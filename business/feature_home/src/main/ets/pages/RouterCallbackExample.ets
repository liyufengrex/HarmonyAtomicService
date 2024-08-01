import { CommonFillButton } from '@ohos/fast_ui/Index'
import { FastRouter, RouterModel } from '@ohos/fast_util/Index';
import { PagePathConstants } from '@ohos/global_constant/Index';

/// 两种路由方式跳转回调示例
@Component
export struct RouterCallbackExample {
  @Consume('navPathStack') navPathStack: NavPathStack;
  @State receiveData: string = ''
  params1: string = '112233'
  params2: string = '223344'

  // navPath 方式跳转并获取回调， 对应页面为 -> TestNavPathJumpPage
  navPathStackJump() {
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

  // router 方式跳转并获取回调
  routerJump() {
    const routerParams: RouterModel = {
      url: '@bundle:com.rex.harmony.atomic.service/feature_hsp_page/ets/pages/TestHspHomePage',
      params: this.params2,
      popCallback: (callbackValue) => {
        if (callbackValue !== undefined) {
          this.receiveData = callbackValue.toString()
        }
      }
    }
    FastRouter.push(routerParams)
  }

  build() {
    NavDestination() {
      Column() {
        Text(this.receiveData)
          .fontSize('17vp')
          .margin({
            bottom: '60vp'
          })

        Text(`传递入参：${this.params1}`)
          .fontSize('15vp')
          .margin({
            bottom: '5vp'
          })
        CommonFillButton({
          text: 'NavPathStack 跳转回调',
          horizontalPadding: '40vp',
          verticalPadding: '10vp',
          event: () => {
            this.navPathStackJump()
          }
        })

        Text(`传递入参：${this.params2}`)
          .fontSize('15vp')
          .margin({
            top: '30vp',
            bottom: '5vp'
          })
        CommonFillButton({
          text: 'Router 跳转回调',
          horizontalPadding: '40vp',
          verticalPadding: '10vp',
          event: () => {
            this.routerJump()
          }
        })

      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('路由跳转回调示例')
  }
}