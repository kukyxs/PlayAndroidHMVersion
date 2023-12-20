import { BaseLazyDataSource } from '../../../../../../base/BaseLazyDataSource';
import { HomeBannerData } from '../../../../../../entity/HomeBanner';

export class BannerDataSource extends BaseLazyDataSource {
  private banners: HomeBannerData[]

  constructor(bannerList: HomeBannerData[]) {
    super()
    this.banners = bannerList
  }

  public totalCount(): number {
    return this.banners.length
  }

  public getData(index: number): HomeBannerData {
    return this.banners[index]
  }

  public replaceData(banners: HomeBannerData[]) {
    this.banners = banners
    this.notifyDataReload()
  }
}