/// 节流
export function Throttle(period: number): MethodDecorator {
  return function (
      target: any,
      propertyKey: string,
      descriptor: PropertyDescriptor
  ): PropertyDescriptor {
    const originalMethod = descriptor.value
    let timeID: number = 0
    descriptor.value = function (...args: any[]): void {
      if (timeID === 0) {
        originalMethod.apply(this, args)
        timeID = setTimeout(() => {
          timeID = 0
        },
          period
        )
      }
    }
    return descriptor
  }
}

/// 防抖
export function Debounce(period: number): MethodDecorator {
  return function (
      target: any,
      propertyKey: string,
      descriptor: PropertyDescriptor
  ): PropertyDescriptor {
    const originalMethod = descriptor.value
    let timeID: number = 0
    descriptor.value = function (...args: any[]): void {
      if (timeID !== 0) {
        clearTimeout(timeID)
      }
      timeID = setTimeout(() => {
        originalMethod.apply(this, args)
        timeID = 0
      },
        period
      )
    }
    return descriptor
  }
}