import router from '@ohos.router'

export function viewAppInnerUrl(title: string, url: string) {
  router.pushUrl({ url: 'pages/detail/WebDetail', params: { 'title': title, "url": url } })
}