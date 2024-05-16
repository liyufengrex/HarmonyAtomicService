import { bundleManager } from '@kit.AbilityKit';

abstract class FastTool {
  /// 获取应用包名的方法
  public static get bundleName(): string {
    const info = bundleManager.getBundleInfoForSelfSync(bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT)
    return info.name;
  }
}