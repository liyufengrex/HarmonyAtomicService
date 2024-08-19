// 云数据库
// 文档：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/cloudfoundation-database-initialize-V5
// 云数据库对应配置文件： entry/src/main/resources/rawfile/schema.json
import { cloudDatabase } from '@kit.CloudFoundationKit';
import { FastToast } from '@ohos/fast_ui';
import { LogReport } from '../cloudDb/LogReport';

@Component
export struct CloudDatabaseExample {
  @State logContent: string = ''
  @State logData: LogReport[] = []

  aboutToAppear(): void {
    this.queryCloudData()
  }

  getCurrentTime(): string {
    let date = new Date();
    return `${date.getFullYear()}-${date.getMonth() +
      1}-${date.getDate()} ${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`;
  }

  async upsertCloudData() {
    try {
      if (this.logContent !== '') {
        // CodeLabDemo 是AGC开发平台上创建的存储区名称
        let databaseZone = cloudDatabase.zone("CodeLabDemo");
        let log = new LogReport();
        log.id = new Date().getMilliseconds()
        log.content = this.logContent;
        log.time = this.getCurrentTime();
        await databaseZone.upsert(log);
        FastToast.shortToast(`写入成功`);
        this.logContent = '';
        this.queryCloudData();
      }
    } catch (err) {
      FastToast.shortToast(`写入失败: ${err.message}`);
    }
  }

  async queryCloudData() {
    try {
      let condition = new cloudDatabase.DatabaseQuery(LogReport);
      let databaseZone = cloudDatabase.zone("CodeLabDemo");
      let resultArray = await databaseZone.query(condition);
      this.logData = resultArray;
    } catch (err) {
      FastToast.shortToast(`Failed to query Code: ${err.code}, message: ${err.message}`);
    }
  }

  async deleteCloudData(data: LogReport) {
    try {
      let databaseZone = cloudDatabase.zone("CodeLabDemo");
      await databaseZone.delete(data);
      FastToast.shortToast(`删除成功`);
      this.queryCloudData()
    } catch (err) {
      FastToast.shortToast(`删除失败: ${err.message}`);
    }
  }

  build() {
    NavDestination() {
      Column() {

        TextInput({ placeholder: "输入任意内容", text: `${this.logContent}` })
          .width('90%')
          .onChange((value: string) => {
            this.logContent = value;
          })

        Button('写入云数据库', { type: ButtonType.Capsule, stateEffect: true })
          .margin({ top: '100px', bottom: '100px' })
          .width('90%')
          .onClick(() => {
            this.upsertCloudData();
          })

        Text('下方同步显示云端数据').fontSize(11).margin({ bottom: '35px' })
        this.logDataListView()
      }
      .justifyContent(FlexAlign.Start)
      .margin({
        top: 20
      })
      .width('100%')
      .height('100%')
    }
    .title('云数据库使用示例')
  }

  @Builder
  logDataListView() {
    List() {
      ForEach(this.logData, (item: LogReport) => {
        ListItem() {
          Row() {
            Text(item.time).fontSize(12).margin({ right: 15 })
            Text(item.content).fontSize(13)
          }
          .width('100%')
          .padding(10)
        }.onClick(() => {
          this.deleteCloudData(item)
        })
      })
    }
    .width('90%')
    .layoutWeight(1)
    .borderRadius(8)
    .backgroundColor('#FFE2E5E7')
    .margin({
      bottom: '80px'
    })
    .divider({
      strokeWidth: 1,
      color: Color.White
    })
  }
}