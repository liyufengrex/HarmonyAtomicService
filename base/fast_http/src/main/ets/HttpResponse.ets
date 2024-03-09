import http from '@ohos.net.http'
import { BaseRequestOption } from './base/HttpRequestOption'

export default class HttpResponse {
  readonly httpResponse: http.HttpResponse
  readonly requestOptions: BaseRequestOption

  constructor(response: http.HttpResponse, options: BaseRequestOption) {
    this.httpResponse = response
    this.requestOptions = options
  }

  get responseCode(): http.ResponseCode | number {
    return this.httpResponse.responseCode
  }

  get result(): string | Object | ArrayBuffer {
    return this.httpResponse.result
  }

  get header(): Object {
    return this.httpResponse.header
  }

  get httpSuccess(): boolean {
    return this.responseCode === http.ResponseCode.OK
  }
}