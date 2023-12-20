import { BaseLazyDataSource } from '../../../../../../base/BaseLazyDataSource'
import { HomeArticleData } from '../../../../../../entity/HomeArticle'

export class ArticleDataSource extends BaseLazyDataSource {
  private articles: HomeArticleData[]

  constructor(articleList: HomeArticleData[]) {
    super()
    this.articles = articleList
  }

  public totalCount() {
    return this.articles.length
  }

  public getData(index: number): HomeArticleData {
    return this.articles[index]
  }

  public replaceData(articleList: HomeArticleData[]) {
    this.articles = articleList
    this.notifyDataReload()
  }

  public appendList(articleList: HomeArticleData[]) {
    let start = this.articles.length
    this.articles.push(...articleList)
    this.notifyDataAdd(start)
  }
}