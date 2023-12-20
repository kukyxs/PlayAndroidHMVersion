import { HomeArticleContent } from './tabContents/home/HomeArticleContent'

@Component
export struct MainContent {
  @Link contentIndex: number

  build() {
    Column() {
      HomeArticleContent()
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}