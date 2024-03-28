import { emitter } from '@kit.BasicServicesKit';

/// 事件通知工具类
export abstract class EventBus {
  static send(
    eventID: string,
    eventData?: Object | Record<string, Object> | null,
  ) {
    let data: string | undefined
    if (eventData !== null && eventData !== undefined) {
      if (typeof eventData === 'string') {
        data = eventData
      } else {
        data = JSON.stringify(eventData)
      }
    }

    emitter.emit(
      eventID,
      {
        priority: emitter.EventPriority.HIGH
      },
      {
        data: {
          'data': data
        }
      },
    );
  }

  static listen<T>(
    eventID: string,
    callback: (data?: T) => void,
  ) {
    emitter.on(
      eventID,
      (eventData: emitter.EventData) => {
        let data: string | undefined = eventData.data!['data']
        if (data == undefined) {
          callback(undefined)
        } else {
          if (data.startsWith("{") && data.endsWith("}")) {
            callback(JSON.parse(data) as T)
          } else {
            callback(data as T)
          }
        }
      },
    );
  }

  static cancel(eventID: string) {
    emitter.off(eventID);
  }
}