import { CommonFillButton } from '@ohos/fast_ui/Index'
import { FastRouter, RouterModel } from '@ohos/fast_util/Index';
import { PagePathConstants } from '@ohos/global_constant/Index';

/// 两种路由方式跳转回调示例
@Component
export struct RouterCallbackExample {
  @Consume('navPathStack') navPathStack: NavPathStack;
  @State receiveData: string = ''

  // NavPatchStack 方式跳转并获取回调
  navPathStackJump() {
    const routerParams: RouterModel = {
      params: '我是入参 123',
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
      params: '我是入参 1488',
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
      Column({ space: '20vp' }) {
        Text(`回调返回值：${this.receiveData}`).fontSize('18vp')
        CommonFillButton({
          text: 'NavPathStack 跳转回调',
          horizontalPadding: '40vp',
          verticalPadding: '10vp',
          event: () => {
            this.navPathStackJump()
          }
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
    }.title('路由跳转回调示例')
  }
}

@Component
export struct TestNavPathPage {
  @Consume('navPathStack') navPathStack: NavPathStack;
  routerParams?: RouterModel
  @State receiveParams: string = ''

  aboutToAppear(): void {
    this.receiveParams = this.routerParams!.params!.toString()
  }

  build() {
    NavDestination() {
      Column({ space: '30vp' }) {
        Text(`接收到的入参：${this.receiveParams}`).fontSize('18vp')
        CommonFillButton({
          text: '关闭并返回结果',
          horizontalPadding: '40vp',
          verticalPadding: '10vp',
          event: () => {
            if (this.routerParams?.popCallback !== undefined) {
              this.routerParams.popCallback('我是回调的结果 345 ')
            }
            this.navPathStack.pop()
          }
        })
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }.title('跳转目标页')
  }
}