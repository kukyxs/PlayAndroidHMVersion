import { HomeArticleData } from '../../../../../entity/HomeArticle'
import { HomeBannerData } from '../../../../../entity/HomeBanner'
import { viewAppInnerUrl } from '../../../../../utils/AppJumper'
import { HomeArticleRepo } from './HomeArticleRepo'
import { ArticleDataSource } from './source/ArticleSource'
import { BannerDataSource } from './source/BannerSource'

@Component
export struct HomeArticleContent {
  @State firstItemIndex: number = 0
  @State isLoadMore: boolean = false
  @State isRefreshing: boolean = true
  private repo: HomeArticleRepo = new HomeArticleRepo()
  private bannerController: SwiperController = new SwiperController()
  private articleScroller: Scroller = new Scroller()
  private bannerDataSource: BannerDataSource = new BannerDataSource([])
  private articleDataSource: ArticleDataSource = new ArticleDataSource([])
  private articlePage: number = 0

  aboutToAppear() {
    this.requestBannerList()
    this.requestArticle()
  }

  async requestBannerList() {
    this.bannerDataSource.replaceData(await this.repo.requestHomeBanner())
  }

  async requestArticle(page: number = 0) {
    if (page === 0) {
      this.articleDataSource.replaceData(await this.repo.requestArticles())
      this.isRefreshing = false
    } else {
      let articles = await this.repo.requestArticles(page)
      this.isLoadMore = false
        articles.length > 0 ? this.articleDataSource.appendList(articles) : this.articlePage--
    }
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // 轮播图
        Swiper(this.bannerController) {
          LazyForEach(this.bannerDataSource, (item: HomeBannerData) => {
            Image(item.imagePath).width('100%').height('25%')
              .objectFit(ImageFit.Cover)
              .onClick(() => viewAppInnerUrl(item.title, item.url))
          }, item => item.id)
        }
        .autoPlay(true)
        .interval(3000)
        .loop(true)
        .displayMode(SwiperDisplayMode.Stretch)
        .indicatorStyle({ bottom: 12, right: 12, selectedColor: $r('app.color.theme_color') })

        // 刷新
        Refresh({ refreshing: $$this.isRefreshing, offset: 50, friction: 50 }) {
          List({ scroller: this.articleScroller }) {
            LazyForEach(this.articleDataSource, (item: HomeArticleData) => {
              ListItem() {
                Column() {
                  Text(item.title).fontSize(20).fontColor($r('app.color.text_black'))
                    .padding({ bottom: 16 })

                  Column() {
                    Text(`${item.chapterName}/${item.superChapterName}`)
                      .fontSize(14).fontColor($r('app.color.normal_text'))
                      .padding({ bottom: 8 })

                    Text(`${item.author.length === 0 ? item.shareUser : item.author}  ${item.niceDate}`)
                      .fontSize(14).fontColor($r('app.color.normal_text'))
                  }.alignItems(HorizontalAlign.End)
                  .width('100%')
                }
                .padding({ left: 8, right: 8, top: 12, bottom: 12 })
                .alignItems(HorizontalAlign.Start)
                .width('96%')
                .border({
                  color: $r('app.color.normal_text'),
                  radius: 8, style: BorderStyle.Solid, width: 1
                })
                .onClick(()=> viewAppInnerUrl(item.title, item.link))
              }.width("100%").margin({ top: 12 })
            }, item => item.id)

            // 加载更多 ListItem
            if (this.isLoadMore)
            ListItem() {
              Text('Loading More Data...')
                .width('96%')
                .fontSize(16)
                .padding({ top: 20, bottom: 20 })
                .backgroundColor($r('app.color.light_grey'))
                .textAlign(TextAlign.Center)
                .margin({ top: 12, bottom: 12 })
                .border({ radius: 12 })
            }
          }.width('100%').height("100%").alignListItem(ListItemAlign.Center)
          .onScrollIndex((start, end) => {
            this.firstItemIndex = start
            console.log(`scrollIndex: (${start}->${end})`)
            if (this.articleDataSource.totalCount() > 0 && end >= this.articleDataSource.totalCount() - 1) {
              console.log("scrollIndex: scrollToEnd")
              if (this.isLoadMore) return
              this.isLoadMore = true
              console.log("scrollIndex loadMore")
              this.articlePage++
              this.requestArticle(this.articlePage)
            }
          })
        }
        .width('100%')
        .height('75%').onRefreshing(() => {
          this.articlePage = 0
          this.requestArticle()
        })
      }

      // 返回顶部
      if (this.firstItemIndex > 5)
        Image($r('app.media.ic_to_top')).size({ width: 30, height: 30 })
          .margin({ right: 20, bottom: 50 })
          .onClick(() => {
            this.articleScroller.scrollToIndex(0)
          })

      // 加载中
      if (this.isRefreshing)
      Column() {
        Text('获取数据中..').padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .border({ radius: 8 })
          .fontSize(16)
          .backgroundColor($r('app.color.light_grey'))
      }.alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .width('100%').height('75%')
    }
  }
}