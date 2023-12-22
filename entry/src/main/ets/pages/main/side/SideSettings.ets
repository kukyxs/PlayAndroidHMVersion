@Component
export struct SideSettings {
  @Link currentTab: number
  @Link sideOpen: boolean
  private switchItems: string[] = ["Android", "Music"]

  @Builder SwitchItem(text: string, index: number) {
    Row() {
      Text(text).fontColor($r('app.color.text_black'))
      Blank()
      Image($r('app.media.arrow_right')).size({ width: 20, height: 20 })
    }
    .padding({ left: 16, right: 4, top: 12, bottom: 12 })
    .width('100%')
    .onClick(() => {
      if (this.currentTab === index) return
      this.currentTab = index
      this.sideOpen = false
    })
  }

  build() {
    Column() {
      Row() {
        Text('Kuky').fontSize(20)
          .fontColor($r('app.color.text_black'))
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ top: 80, bottom: 20, left: 16, right: 4 })

      ForEach(this.switchItems, (item, index) => {
        this.SwitchItem(item, index)
      }, item => item)
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.page_background'))
    .border({ radius: { topRight: 8, bottomRight: 8 },
      color: $r('app.color.normal_text'), width: 0.5 },)
  }
}