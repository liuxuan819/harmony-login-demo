import Rate from '../view/Rate'
import { TargetItem } from '../viewModel/TargetItem'

@Extend(Column)
function panelStyle() {
  .width('100%')
  .borderRadius(8)
  .padding(8)
  .backgroundColor('#fff')
}

@Entry
@Component
struct Target {
  @State targetItems: TargetItem[] = [
    new TargetItem('子目标1'),
    new TargetItem('子目标2'),
  ]
  @State updateTime: number = Date.now();

  getUpdateTime(): string {
    const updateTimeDate = new Date(this.updateTime);
    const month = String(updateTimeDate.getMonth() + 1).padStart(2, '0');
    const day = String(updateTimeDate.getDate()).padStart(2, '0');
    const year = updateTimeDate.getFullYear();
    const hours = String(updateTimeDate.getHours()).padStart(2, '0');
    const minutes = String(updateTimeDate.getMinutes()).padStart(2, '0');

    return `${month}/${day}/${year} ${hours}:${minutes}`;
  }

  @Builder
  renderTargetItems() {
    Text('子目标')
      .width('100%')
      .fontSize(24)
      .fontColor('#333')
      .fontWeight(FontWeight.Bold)
      .padding({
        top: 18,
        bottom: 18
      })
    List({ space: 8 }) {
      ForEach(this.targetItems, (item: TargetItem) => {
        ListItem() {
          Column() {
            Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
              Text(item.text)
                .fontColor('#333')
                .fontSize(20)
              Column() {
                Text(item.getRate())
                  .fontWeight(FontWeight.Bold)
                Text(item.getFormatterDate())
                  .fontColor('#999')
              }
              .alignItems(HorizontalAlign.End)
            }
          }
          .panelStyle()
        }
      })
    }
    .width('100%')
    .height('auto')
  }

  build() {
    Column() {
      Text('工作目标')
        .width('100%')
        .fontSize(32)
        .fontColor('#333')
        .fontWeight(FontWeight.Bold)
        .padding({
          top: 12,
          bottom: 12
        })
      Column() {
        Row({ space: 8 }) {
          Image($r("app.media.found"))
            .width(100)
            .height(100)
            .borderRadius(12)
          Column() {
            Text('第一季度运营目标')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 12 })
            Text('实现用户量与活跃度提升')
          }
            .alignItems(HorizontalAlign.Start)
            .padding({
              top: 12,
              left: 8,
            })
            .height(100)
        }
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Column() {
            Text('整体进度')
              .fontWeight(FontWeight.Bold)
              .fontSize(18)
            Text('更新时间:')
              .fontColor('#999')
            Text(this.getUpdateTime())
              .fontWeight(FontWeight.Bold)
              .fontSize(18)
          }
            .alignItems(HorizontalAlign.Start)
          Rate({ numerator: 15, denominator: 20 })
        }
      }
        .panelStyle()
      this.renderTargetItems()
    }
    .backgroundColor('#f1f3f5')
    .width('100%')
    .height('100%')
    .padding(12)
  }
}