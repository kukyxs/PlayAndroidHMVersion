import http from '@ohos.net.http'
import hilog from '@ohos.hilog'

export interface IRequest<T> {
  data: T | null
  errorCode: number
  errorMsg: string
}

let request = http.createHttp()

export function requestData<T>(url: string, reqOptions: http.HttpRequestOptions): Promise<T> {
  return new Promise((resolve, reject) => {
    request.request(url, reqOptions)
      .then((res) => {
        let json = JSON.parse(res.result as string)
        let code = json['errorCode']
        hilog.error(0x0001, "RequestData", "code: " + code)
        if (code === 0) {
          let data = json as IRequest<T>
          resolve(data.data)
        } else {
          reject(res.result['errorMsg'])
        }
      }).catch((err) => {
      reject(err.message)
    })
  })
}