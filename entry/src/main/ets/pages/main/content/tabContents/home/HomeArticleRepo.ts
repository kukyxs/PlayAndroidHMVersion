import http from '@ohos.net.http'
import hilog from '@ohos.hilog'
import { HomeBannerData } from '../../../../../entity/HomeBanner'
import { homeArticleApi, homeBanner } from '../../../../../utils/Config'
import { requestData } from '../../../../../utils/Request'
import { HomeArticle, HomeArticleData } from '../../../../../entity/HomeArticle'

export class HomeArticleRepo {
  /**
   * 请求 Banner 列表
   * @returns
   */
  async requestHomeBanner(): Promise<HomeBannerData[]> {
    try {
      let banners = await requestData<HomeBannerData[]>(homeBanner,
        {
          method: http.RequestMethod.GET
        })
      hilog.error(0x0000, "RequestBanner", banners.map((item) => item.url).toString())
      return banners
    } catch (e) {
      hilog.error(0x0000, "RequestBannerErr", e)
      return []
    }
  }

  /**
   * 请求文章列表
   * @returns
   */
  async requestArticles(page: number = 0): Promise<HomeArticleData[]> {
    try {
      let article = await requestData<HomeArticle>(
        homeArticleApi(page), {
        method: http.RequestMethod.GET
      })
      hilog.error(0x0000, "RequestArticle", article.datas.map((item) => item.id).toString())
      return article.datas
    } catch (e) {
      hilog.error(0x0000, "RequestArticleErr", e)
      return []
    }
  }
}