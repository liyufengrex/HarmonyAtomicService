// 简易授权示例
import { CommonFillButton, FastToast } from '@ohos/fast_ui/Index'
import { Permission } from '@ohos/fast_util/Index'
import { common } from '@kit.AbilityKit'

@Component
export struct PermissionExample {
  @State count: number = 0

  @Builder
  testPermissionButton() {
    CommonFillButton({
      text: '授权成功后+1',
      event: () => {
        this.onClickTap('rex')
      }
    })
  }

  @Permission(
  getContext(this) as common.UIAbilityContext,
  ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION']
  )
  onClickTap(name: string) {
    this.count++
  }

  permissionErrorHandler() {
    FastToast.shortToast('请求权限失败')
  }

  build() {
    NavDestination() {
      Column({ space: '15vp' }) {
        Text(this.count.toString())
          .fontSize('20vp')
        this.testPermissionButton()
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
    }
    .title('简易授权示例')
  }
}