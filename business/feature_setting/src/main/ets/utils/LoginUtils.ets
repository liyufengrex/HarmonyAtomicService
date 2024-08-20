import { common } from '@kit.AbilityKit'
import { authentication } from '@kit.AccountKit'
import util from '@ohos.util'
import { FastToast } from '@ohos/fast_ui'

// 文档：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/account-phone-unionid-login-V5
export abstract class LoginUtil {
  public static async login(context?: common.Context): Promise<LoginCallbackRes | undefined> {
    let huaweiIdProvider = new authentication.HuaweiIDProvider()
    let loginRequest = huaweiIdProvider.createLoginWithHuaweiIDRequest()
    // 当用户未登录华为账号时，是否强制拉起华为账号登录界面
    loginRequest.forceLogin = true
    // 用于防跨站点请求伪造，推荐采用如下方式给state赋值
    loginRequest.state = util.generateRandomUUID();
    let controller = new authentication.AuthenticationController(context)
    try {
      const data = await controller.executeRequest(loginRequest)
      let resp = data as authentication.LoginWithHuaweiIDResponse;
      if (resp.data === undefined) {
        return undefined;
      }
      let state: string = resp.state!;
      if (loginRequest.state != state) {
        FastToast.shortToast('login false: The state is different.')
        return undefined;
      }
      let loginWithHuaweiIDCredential: authentication.LoginWithHuaweiIDCredential = resp.data;
      let code: string = loginWithHuaweiIDCredential.authorizationCode!;
      let openID: string = loginWithHuaweiIDCredential.openID;
      let unionID: string = loginWithHuaweiIDCredential.unionID;
      let result: LoginCallbackRes = {
        code: code,
        openID: openID,
        unionID: unionID,
      };
      return result;
    } catch (e) {
      FastToast.shortToast(`login false: ${e.code} - ${e.message}`)
      return undefined;
    }
  }
}

export interface LoginCallbackRes {
  code: string,
  openID: string,
  unionID: string,
}