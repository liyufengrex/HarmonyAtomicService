// 云函数调用示例
// 文档：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/cloudfoundation-call-function-V5
// 云函数对应配置文件： AppScope/resources/rawfile/agconnect-services.json
import { cloudFunction } from '@kit.CloudFoundationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { ObjectUtil } from '@ohos/fast_util';

@Component
export struct CloudFuncExample {
  @State year: string = '';
  @State functionResult: string = '';

  callFunction() {
    cloudFunction.call({
      name: "cloundfunction", //对应创建的云函数名称
      version: "$latest", //如果不传入版本号，默认为“$latest”。
      timeout: 10 * 1000, //单位为毫秒，默认为70*1000毫秒。
      data: {
        year: this.year,
      }
    }).then((value: cloudFunction.FunctionResult) => {
      // 返回结果为 {'result':'***'}
      let objectMap = ObjectUtil.objectToMap(value.result!)
      this.functionResult = objectMap.get('result')!.toString();
    }).catch((err: BusinessError) => {
      console.error(`Failed to call the function, Code: ${err.code}, message: ${err.message}`);
    })
  }

  build() {
    NavDestination() {
      Column() {

        TextInput({ placeholder: "输入年份查询对应生肖" })
          .width('90%')
          .onChange((value: string) => {
            this.year = value;
          })

        Button('调用云函数查询', { type: ButtonType.Capsule, stateEffect: true })
          .margin({ top: '100px', bottom: '100px' })
          .width('90%')
          .onClick(() => {
            this.callFunction();
          })

        Text("生肖: " + this.functionResult)
          .textAlign(TextAlign.Center)
          .fontSize(20)
          .padding(10)
          .width('90%')

      }
      .justifyContent(FlexAlign.Start)
      .margin({
        top: 20
      })
      .width('100%')
      .height('100%')
    }
    .title('云函数调用示例')
  }
}