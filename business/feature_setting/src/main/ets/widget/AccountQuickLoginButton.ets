/// 华为账号快速登录按钮
import { LoginCallbackRes, LoginUtil } from '../utils/LoginUtils';
import common from '@ohos.app.ability.common';

@Builder
export function AccountQuickLoginButton(callback: AccountQuickLoginCallback) {
  Button() {
    Text('华为账号快速登录')
      .fontColor('#FFFFFF')
      .fontSize(14)
      .fontWeight(FontWeight.Bold)
      .fontStyle(FontStyle.Normal)
  }
  .backgroundColor(Color.Black)
  .type(ButtonType.Capsule)
  .width('80%')
  .height(44)
  .onClick(() => {
    LoginUtil.login(callback.context).then((data) => {
      if (data !== undefined) {
        // 获取成功
        callback.onLoginCallback(data);
      }
    })
  })
}

export interface AccountQuickLoginCallback {
  context: common.Context
  onLoginCallback: (data: LoginCallbackRes) => void
}