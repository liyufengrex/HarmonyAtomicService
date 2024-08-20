import { FunctionalButton, functionalButtonComponentManager } from '@kit.ScenarioFusionKit'
import { FastToast } from '@ohos/fast_ui'

export type QuickVerifyPhoneCallback = (value: string) => void

/// 快速验证手机号按钮
@Builder
export function QuickVerifyPhoneButton(callback: QuickVerifyPhoneCallback) {
  FunctionalButton(
    {
      params: {
        openType: functionalButtonComponentManager.OpenType.GET_PHONE_NUMBER,
        label: '快速验证手机号',
        styleOption: {
          styleConfig: new functionalButtonComponentManager.ButtonConfig()
            .type(ButtonType.Normal)
            .backgroundColor($r('app.color.secondary'))
            .width('80%')
            .height(44)
            .borderRadius(22)
            .fontColor($r('app.color.primary'))
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .padding(0)
            .borderWidth(0)
        }
      },
      controller: new functionalButtonComponentManager.FunctionalButtonController()
        .onGetPhoneNumber(
          async (err, data) => {
            if (err !== undefined) {
              FastToast.shortToast(`login false: ${err.code} - ${err.message}`)
            } else {
              // authorizationCode 是手机号的加密字符串，后端通过调用华为服务可解析出手机号的明文
              // 参考文档：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/account-phone-unionid-login-V5#section286103315177
              let authorizationCode = data.code
              if (authorizationCode !== undefined) {
                callback(authorizationCode)
              }
            }
          }
        )
    }
  )
}