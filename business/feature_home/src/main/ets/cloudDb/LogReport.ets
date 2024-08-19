import { cloudDatabase } from '@kit.CloudFoundationKit';

/// 对应创建的云数据库对象类型‘LogReport’
class LogReport extends cloudDatabase.DatabaseObject {
  public naturalbase_ClassName(): string {
    return "LogReport";
  }

  public id: number | undefined;
  public content: string | undefined;
  public time: string | undefined;
}

export { LogReport };