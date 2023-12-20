import hilog from '@ohos.hilog'
import { MainContent } from './content/MainContent'
import { SideSettings } from './side/SideSettings'

@Component
@Entry
struct AppMain {
  @State sideBarOpened: boolean = false
  @State currentTab: number = 0

  build() {
    SideBarContainer(SideBarContainerType.Overlay) {
      SideSettings({ currentTab: $currentTab, sideOpen: $sideBarOpened })
        .width('100%').height('100%')

      MainContent({ contentIndex: $currentTab })
        .width('100%').height('100%')
    }
    .controlButton({
      top: 16,
      icons: {
        shown: $r('app.media.menu_fold'),
        hidden: $r("app.media.menu_unfold"),
        switching: ''
      }
    })
    .width('100%')
    .height('100%')
    .minSideBarWidth(100)
    .maxSideBarWidth('80%')
    .onChange((v) => {
      hilog.error(0x000, 'Main', '====> sidebar state change: ' + v)
      this.sideBarOpened = v
    })
    .showSideBar(this.sideBarOpened)
  }
}