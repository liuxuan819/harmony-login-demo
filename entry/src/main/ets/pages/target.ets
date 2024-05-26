import Dialog from '../view/Dialog'
import Rate from '../view/Rate'
import { getFormattedDateByTimestamp } from '../viewModel/common'
import { TargetItem } from '../viewModel/TargetItem'

@Entry
@Component
struct Target {
  @State targetItems: TargetItem[] = [
    new TargetItem('子目标1'),
    new TargetItem('子目标2'),
    new TargetItem('子目标3'),
  ]
  @State updateTime: number = Date.now();
  @State isEditMode: boolean = false;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: Dialog({
      confirm: (value: string): void => this.saveTarget(value)
    }),
    alignment: DialogAlignment.Center,
    customStyle: true,
    autoCancel: false,
  });

  getUpdateTime(): string {
    return getFormattedDateByTimestamp(this.updateTime);
  }

  setUpdateTime(timestamp: number = Date.now()): void {
    this.updateTime = timestamp;
  }

  getRate(): { numerator: number, denominator: number } {
    return {
      numerator: this.targetItems.filter(item => item.isCompleted()).length,
      denominator: this.targetItems.length,
    };
  }

  saveTarget(text: string): void {
    const newItem = new TargetItem(text);
    this.targetItems.push(newItem);
    this.setUpdateTime(newItem.getUpdateTimestamp());
  }

  @Builder
  renderTargetHeader() {
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
        .width('100%')
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
        Rate(this.getRate())
      }
    }
    .panelStyle()
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
              Text(item.getText())
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
    .height('52%')
  }

  @Builder
  renderButton() {
    if(this.isEditMode) {
      Button('删除')
        .buttonStyle()
        .fontColor(Color.Red)
    } else {
      Button('添加子目标')
        .buttonStyle()
        .fontColor('#00adef')
        .onClick(() => this.dialogController.open())
    }
  }

  build() {
    Column() {
      this.renderTargetHeader()
      this.renderTargetItems()
      Blank()
      this.renderButton()
    }
    .backgroundColor('#f1f3f5')
    .width('100%')
    .height('100%')
    .padding(12)
  }
}

@Extend(Column)
function panelStyle() {
  .width('100%')
  .borderRadius(8)
  .padding(8)
  .backgroundColor('#fff')
}

@Extend(Button)
function buttonStyle() {
  .width(156)
  .height(40)
  .fontSize(16)
  .fontWeight(FontWeight.Medium)
  .backgroundColor('#0D182431')
}
