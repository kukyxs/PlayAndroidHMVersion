import curves from '@ohos.curves'

@Preview
@Component
export struct MusicPlayerContent {
  @State playRotateAngle: number = 60
  @State playerRotateAngle: number = 0
  @State isAnimating: boolean = false
  private intervalId: number | null

  startRotate() {
    animateTo({
      duration: 1000,
      curve: Curve.Linear,
      iterations: 1,
      playMode: PlayMode.Normal,
    }, () => {
      this.playRotateAngle = 90
    })

    this.isAnimating = true
    this.intervalId = setInterval(() => {
      this.playerRotateAngle += 1
    }, 50)
  }

  stopRotate() {
    animateTo({
      duration: 1000,
      curve: Curve.Linear,
      iterations: 1,
      playMode: PlayMode.Normal,
    }, () => {
      this.playRotateAngle = 60
    })
    this.isAnimating = false
    if (this.intervalId) {
      clearInterval(this.intervalId)
    }
  }

  build() {
    Column() {
      RelativeContainer() {
        Stack({ alignContent: Alignment.Center }) {
          Image($r("app.media.music_album"))

          Image($r('app.media.jay_chou'))
            .margin(50).border({ radius: 100 })
            .rotate({ centerX: '50%', centerY: '50%', angle: this.playerRotateAngle % 360 })
        }
        .width(300)
        .height(300)
        .backgroundColor('#44FFFFFF')
        .border({ radius: 150, color: '#66CCCCCC', width: 1 })
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .id('center')

        Text('Play111111').alignRules({
          top: { anchor: '__container__', align: VerticalAlign.Top },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        }).margin({ top: 80 })
          .rotate({  centerX: '50%', centerY: 80, angle: this.playRotateAngle })
          .id('top')
      }.width('100%').height('70%')

      Button(this.isAnimating ? '关闭' : "旋转")
        .onClick(() => {
          this.isAnimating ? this.stopRotate() : this.startRotate()
        })
    }.width('100%').height('100%')
    .padding(12)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[$r('app.color.music_bg_start'), 0], [$r('app.color.music_bg_end'), 1]]
    })
  }
}