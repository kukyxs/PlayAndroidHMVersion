import { HomeArticleContent } from './tabContents/home/HomeArticleContent'
import { MusicPlayerContent } from './tabContents/music/MusicPlayer'

@Component
export struct MainContent {
  @Link contentIndex: number

  build() {
    Column() {
      if (this.contentIndex === 0) HomeArticleContent()
      else if (this.contentIndex === 1) MusicPlayerContent()
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background'))
  }
}