import router from '@ohos.router'

export interface AppbarAttribute {
  title: string
  backPress: () => void | null
}

@Component
export struct AppBar {
  public attribute: AppbarAttribute

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Text(this.attribute.title)
        .width('100%')
        .fontSize(20)
        .fontColor($r('app.color.text_black'))
        .padding({ left: 50, right: 50, top: 30, bottom: 30 })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Center)

      Image($r('app.media.ic_arrow_left')).width(30).height(30)
        .margin({left: 16})
        .onClick(this.attribute.backPress === null ? () => router.back() : this.attribute.backPress)
    }.width('100%')
  }
}