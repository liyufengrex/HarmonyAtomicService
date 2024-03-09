import { promptAction } from '@kit.ArkUI';

export class FastToast {
  static showToast(message: ResourceStr | string, duration: number) {
    promptAction.showToast({ message: message, duration: duration });
  }

  static shortToast(message: ResourceStr | string) {
    FastToast.showToast(message, 1000);
  }

  static longToast(message: ResourceStr | string) {
    FastToast.showToast(message, 3000);
  }
}