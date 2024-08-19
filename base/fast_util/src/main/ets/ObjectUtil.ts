export type ObjectOrNull = Object | undefined | null

export abstract class ObjectUtil {
  /**
   * 将对象转换成hashCode，用于对象的唯一标识
   * @param obj
   * @returns
   */
  static hashCode(obj: object): number {
    let hash = 0
    let i = 0
    let chr: number = 0;
    let str = JSON.stringify(obj)
    if (str.length === 0) {
      return hash;
    }
    for (i = 0; i < str.length; i++) {
      chr = str.charCodeAt(i);
      hash = ((hash << 5) - hash) + chr;
      hash |= 0; // 将 hash 转换为 32 位整数
    }
    return hash
  }

  /**
   *  判断是否是对象
   * @param obj
   * @returns
   */
  static isObject(obj: ObjectOrNull): boolean {
    return typeof obj === 'object' && obj !== null
  }

  /**
   * 判断是否为空
   * @param obj
   * @returns
   */
  static isEmpty(obj: ObjectOrNull): boolean {
    let isEmpty = obj === undefined || obj === null
    if (typeof obj === 'string') {
      isEmpty = isEmpty || obj.trim().length === 0
    }
    return isEmpty
  }

  /**
   * 判断是否不为空
   * @param obj
   * @returns
   */
  static isNotEmpty(obj: ObjectOrNull): boolean {
    return !ObjectUtil.isEmpty(obj)
  }

  /**
   * 判断是否存在属性
   * @param obj
   * @param propertyName
   * @returns
   */
  static hasProperty(obj: ObjectOrNull, propertyName: string): boolean {
    if (!ObjectUtil.isObject(obj)) {
      return false
    }
    for (const key of Object.keys(obj!)) {
      if (key === propertyName) {
        return true
      }
    }
    return false
  }

  /**
   * 对象深拷贝
   * @param obj
   * @returns
   */
  static deepCopy(obj: object): object {
    let newObj: Record<string, Object> | Object[] = Array.isArray(obj) ? [] : {};
    for (let key of Object.keys(obj)) {
      if (ObjectUtil.isObject(obj[key])) {
        newObj[key] = ObjectUtil.deepCopy(obj[key]);
      } else {
        newObj[key] = obj[key];
      }
    }
    return newObj;
  }

  /**
   * 对象浅拷贝
   * @param obj
   * @returns
   */
  static shallowCopy(obj: object): object {
    let newObj: Record<string, Object> = {};
    for (let key of Object.keys(obj)) {
      newObj[key] = obj[key];
    }
    return newObj;
  }

  /**
   * 对象转map
   * @param obj
   * @returns
   */
  static objectToMap(obj: Object): Map<string, Object> {
    let map = new Map<string, Object>();
    if (obj instanceof Array) {
      for (let i = 0; i < obj.length; i++) {
        if (ObjectUtil.isObject(obj[i])) {
          map.set(i.toString(), ObjectUtil.objectToMap(obj[i]));
        } else {
          map.set(i.toString(), obj[i]);
        }
      }
    } else if (ObjectUtil.isObject(obj)) {
      for (let key in obj) {
        if (ObjectUtil.isObject(obj[key])) {
          map.set(key, ObjectUtil.objectToMap(obj[key]));
        } else {
          map.set(key, obj[key]);
        }
      }
    }
    return map;
  }
}