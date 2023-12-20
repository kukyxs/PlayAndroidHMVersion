const ApiHost = 'https://www.wanandroid.com/'

export const homeBanner = `${ApiHost}banner/json`

export const homeArticleApi = (page: number) => {
  return ApiHost + `article/list/${page}/json`
}