import { QuickVerifyPhoneButton } from '../widget/QuickVerifyPhoneButton';
import { AccountQuickLoginButton } from '../widget/AccountQuickLoginButton';
import { LoginCallbackRes } from '../utils/LoginUtils';

@Component
export struct SettingPage {
  build() {
    Column() {
      LoginPanel()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct LoginPanel {
  @State accountQuickLoginRes: LoginCallbackRes | undefined = undefined
  @State quickVerifyPhoneNumber: string | undefined = undefined

  build() {
    Column({ space: 30 }) {

      LoginInfoPanel({
        accountQuickLoginRes: this.accountQuickLoginRes
      })

      AccountQuickLoginButton({
        context: getContext(this),
        onLoginCallback: (data) => {
          this.accountQuickLoginRes = data;
        }
      })

      QuickVerifyPhoneButton((value) => {
        this.quickVerifyPhoneNumber = value;
      })

    }
    .padding({
      left: 16,
      right: 16
    })
    .width('100%')
    .height('100%')
  }
}

@Component
struct LoginInfoPanel {
  @Prop accountQuickLoginRes: LoginCallbackRes | undefined
  @Prop quickVerifyPhoneNumber: string | undefined

  build() {
    Column() {
      if (this.accountQuickLoginRes !== undefined) {
        Text('华为账号快速登录').fontSize(18).fontWeight(FontWeight.Bolder)
        Text(`获取到的 openID :`).infoLabelStyle()
        Text(this.accountQuickLoginRes.openID).infoTextStyle()
        Text(`获取到的 unionID :`).infoLabelStyle()
        Text(this.accountQuickLoginRes.unionID).infoTextStyle()
      }
      if (this.accountQuickLoginRes !== undefined && this.quickVerifyPhoneNumber !== undefined) {
        Divider().color(Color.Transparent).height(20)
      }
      if (this.quickVerifyPhoneNumber !== undefined) {
        Text('快速验证手机号').fontSize(18).fontWeight(FontWeight.Bolder).fontColor($r('app.color.primary'))
        Text(`获取到的 authorizationCode :`).infoLabelStyle($r('app.color.primary'))
        Text(this.quickVerifyPhoneNumber).infoTextStyle($r('app.color.primary'))
      }
    }
    .padding({
      left: 20,
      top: 40
    })
    .height('60%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
  }
}

@Extend(Text)
function infoLabelStyle(
  fontColor: Color | Resource = Color.Black
) {
  .fontSize(14)
  .fontColor(fontColor)
  .fontWeight(FontWeight.Bold)
  .margin({
    top: 20
  })
}

@Extend(Text)
function infoTextStyle(
  fontColor: Color | Resource = Color.Black
) {
  .fontSize(11)
  .fontColor(fontColor)
  .fontWeight(FontWeight.Medium)
  .margin({
    top: 10
  })
}

