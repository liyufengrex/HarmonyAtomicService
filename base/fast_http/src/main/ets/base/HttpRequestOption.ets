import http from '@ohos.net.http';
import url from '@ohos.url';
import HttpResponse from '../HttpResponse';

abstract class HttpRequestOption {
  // 每个继承的请求可重写覆盖如下属性
  public abstract domain: string;
  public abstract path: string;
  public method: http.RequestMethod = http.RequestMethod.POST; //请求类型
  public dataType: http.HttpDataType = http.HttpDataType.OBJECT //数据类型
  public header: Record<string, string> = {};
  public getQuery: Record<string, string> = {}; //GET请求数据，用于拼接在url上
  public postBody?: Object; //POST请求的body数据
  // 配置
  public readTimeout: number = 10000;
  public connectTimeout: number = 10000;
  public usingCache: boolean = false;
  public priority: number = 1;

  /// 拼接 domain 及 get 请求中的参数
  protected requestUrl(): string {
    let urlParamsStr = '';
    if (Object.keys(this.getQuery).length > 0) {
      const urlParams = new url.URLParams(this.getQuery);
      urlParamsStr = urlParams.toString();
    }
    let urlStr = urlParamsStr.length > 0 ? `${this.path}?${urlParamsStr}` : this.path;
    const resultUrl = url.URL.parseURL(urlStr, this.domain);
    return resultUrl.toString();
  }

  protected requestOptions(): http.HttpRequestOptions {
    const options: http.HttpRequestOptions = {
      method: this.method,
      extraData: this.postBody,
      expectDataType: this.dataType,
      usingCache: this.usingCache,
      priority: this.priority,
      readTimeout: this.readTimeout,
      connectTimeout: this.readTimeout
    };
    return options;
  }

  /// 发送请求 - 提供上层重写，打印日志等
  protected onRequestChain(request: BaseRequestOption) {
  }

  /// 请求结束 - 提供上层重写，打印日志等
  protected onResponseChain(response: HttpResponse) {
  }

  /// 请求报错 - 提供上层重写，打印日志等
  protected onErrorChain(error: Error) {
  }
}

abstract class BaseRequestOption extends HttpRequestOption {
  public async request(): Promise<HttpResponse> {
    // 每一个httpRequest对应一个HTTP请求任务，不可复用
    let httpRequest = http.createHttp()
    try {
      let response = await httpRequest.request(
        this.requestUrl(),
        this.requestOptions()
      )
      let resultResponse = new HttpResponse(response, this)
      return resultResponse
    } catch (e) {
      this.onErrorChain(e)
      throw e as Error
    } finally {
      httpRequest.destroy()
    }
  }
}

export { BaseRequestOption, http }