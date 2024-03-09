import { BaseRequestOption } from './base/HttpRequestOption';
import HttpResponse from './HttpResponse';

export abstract class HttpRequest <T> extends BaseRequestOption {
  protected  parseDataToBaseModel(response: HttpResponse): T | undefined {
    let data: T | undefined
    const responseData = response.result;
    if (typeof responseData === 'string') {
      data = JSON.parse(responseData) as T
    } else if (typeof responseData === 'object') {
      data = responseData as T
    } else {
      data = responseData as T
    }
    return data
  }

  public async execute(): Promise<T> {
    const response = await this.request()
    const result = this.parseDataToBaseModel(response)
    return result as T;
  }
}