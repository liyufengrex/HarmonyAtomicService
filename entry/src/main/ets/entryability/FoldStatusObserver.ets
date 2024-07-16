import mediaquery from '@ohos.mediaquery'

/// 折叠屏幕变化监听
abstract class FoldStatusObserver {
  public static readonly foldStatusKey = 'foldStatusKey'
  private static listener?: mediaquery.MediaQueryListener

  /// 在 EntryAbility onWindowStageCreate 生命周期内调用
  public static onCreate() {
    FoldStatusObserver.listener = mediaquery.matchMediaSync('screen and (min-width: 400vp)')
    FoldStatusObserver.listener.on('change', FoldStatusObserver.onFoldStatusChange)
  }

  /// 在 EntryAbility onWindowStageDestroy 生命周期内调用
  public static onDestroy() {
    FoldStatusObserver.listener?.off('change', FoldStatusObserver.onFoldStatusChange)
  }

  /// 在任意 Component 内通过使用 `@StorageProp('foldStatusKey') isFold: boolean = false` 进行监听变化
  private static onFoldStatusChange(result: mediaquery.MediaQueryResult): void {
    const status = AppStorage.get<boolean>(FoldStatusObserver.foldStatusKey)
    if (result.matches !== status) {
      AppStorage.set(FoldStatusObserver.foldStatusKey, result.matches)
    }
  }
}

export { FoldStatusObserver }