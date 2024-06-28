import dataPreferences from '@ohos.data.preferences';
import { FastLog } from './FastLog';

let preference: dataPreferences.Preferences;

/// 数据持久化工具
export class PreferencesUtil {
  static readonly TAG: string = "preferences_util";
  static readonly KEY_PREFERENCES = "preferences"
  static readonly PREFERENCES_NAME: string = "fast_preferences";

  // 在 Entity create 进行调用
  static async createPreferences(context: Context) {
    try {
      preference = await dataPreferences.getPreferences(context, PreferencesUtil.PREFERENCES_NAME);
    } catch (err) {
      FastLog.error(PreferencesUtil.TAG, `Failed to get preferences, Cause: ${err}`);
    }
  }

  // 外部可通过这个方法进行监听
  // preference.on('change',(data) => {})
  static async getPreferences(context: Context): Promise<dataPreferences.Preferences> {
    if (!preference) {
      await PreferencesUtil.createPreferences(context);
    }
    return preference
  }

  static async deletePreferences(context: Context): Promise<boolean> {
    try {
      await dataPreferences.deletePreferences(context, PreferencesUtil.PREFERENCES_NAME);
      return true
    } catch (err) {
      FastLog.error(PreferencesUtil.TAG, `Failed to delete preferences, Cause: ${err}`);
      return false
    }
  }

  static async put(key: string, value: Object) {
    try {
      if (typeof value === "object") {
        if (Array.isArray(value)) {
          await preference.put(key, JSON.stringify(value));
        } else {
          await preference.put(key, JSON.stringify(value));
        }
      } else {
        await preference.put(key, value);
      }
    } catch (err) {
      FastLog.error(PreferencesUtil.TAG, `Failed to put value, Cause: ${err}`);
    }
    await preference.flush();
  }

  static async get(key: string): Promise<Object | undefined> {
    let value: Object | undefined = undefined;
    try {
      value = await preference.get(key, undefined);
    } catch (err) {
      FastLog.error(PreferencesUtil.TAG, `Failed to get value, Cause: ${err}`);
    }
    return value;
  }

  static async getEntity(key: string): Promise<Object> {
    let value: string = '';
    try {
      value = (await preference.get(key, '')).toString();
    } catch (err) {
      FastLog.error(PreferencesUtil.TAG, `Failed to get value, Cause: ${err}`);
    }
    if (value === '') {
      return '';
    }
    return JSON.parse(value);
  }

  static async getAll(): Promise<Object | undefined> {
    let value: Object | undefined;
    try {
      value = await preference.getAll();
    } catch (err) {
      FastLog.error(PreferencesUtil.TAG, `Failed to get value, Cause: ${err}`);
    }
    return value;
  }

  static async has(key: string): Promise<boolean> {
    let value: boolean = false;
    try {
      value = await preference.has(key).then();
    } catch (err) {
      FastLog.error(PreferencesUtil.TAG, `Failed to get value, Cause: ${err}`);
    }
    return value;
  }

  static async delete(key: string): Promise<boolean> {
    try {
      await preference.delete(key);
      return true;
    } catch (err) {
      FastLog.error(PreferencesUtil.TAG, `Failed to get value, Cause: ${err}`);
      return false;
    }
  }

  static async clear(): Promise<boolean> {
    try {
      await preference.clear();
      return true;
    } catch (err) {
      FastLog.error(PreferencesUtil.TAG, `Failed to get value, Cause: ${err}`);
      return false;
    }
  }
}

