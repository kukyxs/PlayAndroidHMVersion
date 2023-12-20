import webview from '@ohos.web.webview'
import router from '@ohos.router'
import { AppBar, AppbarAttribute } from '../../widgets/AppBar'

@Entry
@Component
struct WebDetail {
  @State url: string = ''
  @State title: string = ''
  private webviewController = new webview.WebviewController()

  aboutToAppear() {
    let params = router.getParams()
    if (params) {
      this.url = params['url']
      this.title = params['title']
    }
  }

  build() {
    Column() {
      AppBar({ attribute: { title: this.title, backPress: null } }).width('100%')
      Web({ controller: this.webviewController, src: this.url })
        .width('100%')
        .margin({ top: 16 })
        .javaScriptAccess(true)
    }.width('100%').height('100%')
  }
}