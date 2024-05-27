// 定义装饰器函数
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import bundleManager from '@ohos.bundle.bundleManager';
import { common } from '@kit.AbilityKit';

export function Permission(context: common.UIAbilityContext, permissions: Permissions[]) {
  return function (
      target: any,
      propertyKey: string,
      descriptor: PropertyDescriptor
  ) {
    const originalMethod = descriptor.value;
    descriptor.value = function (...args: any[]) {
      checkPermission(permissions)
        .then((grantStatusList: abilityAccessCtrl.GrantStatus[]) => {
          console.log('权限校验结果:', grantStatusList)
          const allPermissionsGranted =
            grantStatusList.every(status => status === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
          if (allPermissionsGranted) {
            return originalMethod.apply(this, args)
          }
          // 如果没有权限，请求权限
          requestPermission(permissions, context)
            .then(() => {
              // 获取权限成功后重新调用方法
              return originalMethod.apply(this, args)
            })
            .catch(() => {
              // 获取权限失败，执行用户注入的处理函数或默认处理逻辑
              const errorHandler = target.permissionErrorHandler || defaultPermissionErrorHandler
              errorHandler()
            })
        })
        .catch((error) => {
          const errorHandler = target.permissionErrorHandler || defaultPermissionErrorHandler
          errorHandler()
        })
    }
    return descriptor
  }
}

// 默认权限处理失败的逻辑
function defaultPermissionErrorHandler() {
  console.log('没有权限执行该方法')
}

async function checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
  let atManager = abilityAccessCtrl.createAtManager()
  let grantStatus: abilityAccessCtrl.GrantStatus
  // 获取应用程序的accessTokenID
  let tokenId: number
  try {
    let bundleInfo: bundleManager.BundleInfo =
      await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION)
    let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo
    tokenId = appInfo.accessTokenId
  } catch (err) {
    console.error(`getBundleInfoForSelf failed, code is ${err.code}, message is ${err.message}`)
  }

  try {
    grantStatus = await atManager.checkAccessToken(tokenId, permission)
  } catch (err) {
    console.error(`checkAccessToken failed, code is ${err.code}, message is ${err.message}`)
  }

  return grantStatus
}

async function checkPermission(permissions: Permissions[]): Promise<abilityAccessCtrl.GrantStatus[]> {

  let grantStatusList: abilityAccessCtrl.GrantStatus[] = []
  for (let index = 0; index < permissions.length; index++) {
    let grantStatus: abilityAccessCtrl.GrantStatus = await checkAccessToken(permissions[index])
    grantStatusList.push(grantStatus)
  }
  return grantStatusList
}

function requestPermission(permissions: Permissions[], context: common.UIAbilityContext): Promise<void> {
  let atManager = abilityAccessCtrl.createAtManager()
  return new Promise<void>((resolve, reject) => {
    atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      let grantStatus: Array<number> = data.authResults
      const allGrant = grantStatus.every(status => status === 0)
      if (allGrant) {
        resolve()
      } else {
        reject()
      }
    }).catch((err) => {
      reject()
      console.error(`requestPermissionsFromUser failed, code is ${err.code}, message is ${err.message}`)
    })
  })
}
