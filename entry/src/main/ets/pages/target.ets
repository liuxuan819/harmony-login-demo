import Dialog from '../view/Dialog'
import Rate from '../view/Rate'
import TargetItemComponent from '../view/TargetItemComponent'
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
  @State focusIndex: number = -1;
  @State @Watch('handleTargetChange') targetChange: boolean = false;
  @State numerator: number = 0;
  @State denominator: number = 0;
  @State @Watch('onCheck') checkStatus: boolean[] = [];
  @State selectAll: boolean = false;

  onPageShow(): void {
    this.updateRate();
  }

  dialogController: CustomDialogController = new CustomDialogController({
    builder: Dialog({
      confirm: (value: string): void => this.saveTarget(value)
    }),
    alignment: DialogAlignment.Center,
    customStyle: true,
    autoCancel: false,
  });

  toggleSelectAll(value: boolean): void {
    this.selectAll = value;
    this.checkStatus = this.targetItems.map(() => value);
  }

  onCheck(): void {
    if (this.checkStatus.every(value => value === true)) {
      this.selectAll = true;
    }
    if (this.checkStatus.some(value => value === false)) {
      this.selectAll = false;
    }
  }

  getUpdateTime(): string {
    return getFormattedDateByTimestamp(this.updateTime);
  }

  setUpdateTime(timestamp: number = Date.now()): void {
    this.updateTime = timestamp;
  }

  updateRate(): void {
    this.numerator = this.targetItems.filter(item => item.isCompleted()).length;
    this.denominator = this.targetItems.length;
  }

  saveTarget(text: string): void {
    if (text) {
      const newItem = new TargetItem(text);
      this.targetItems.push(newItem);
      this.updateRate();
      this.setUpdateTime(newItem.getUpdateTimestamp());
      this.focusIndex = -1;
    }
  }

  handleTargetChange(): void {
    const item = this.targetItems[this.focusIndex];
    this.updateRate();
    this.setUpdateTime(item.getUpdateTimestamp());
  }

  deleteTarget(): void {
    this.targetItems = this.targetItems.filter((item, index) => this.checkStatus[index]);
    this.toggleSelectAll(false);
    this.updateRate();
    this.setUpdateTime();
    this.isEditMode = false;
    this.focusIndex = -1;
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
        Rate({ numerator: this.numerator, denominator: this.denominator })
      }
    }
    .width('100%')
    .borderRadius(8)
    .padding(8)
    .backgroundColor('#fff')
  }

  @Builder
  renderTargetItems() {
    Row() {
      Text('子目标')
        .fontSize(24)
        .fontColor('#333')
        .fontWeight(FontWeight.Bold)
        .padding({
          top: 18,
          bottom: 18
        })
      Blank()
      if (this.targetItems.length > 0) {
        if (this.isEditMode) {
          Text('取消')
            .textStyle()
            .margin({ left: 16 })
            .onClick(() => {
              this.isEditMode = false;
              this.toggleSelectAll(false);
            })
          Text(this.selectAll ? '取消全选' : '全选')
            .textStyle()
            .margin({ left: 16 })
            .onClick(() => this.toggleSelectAll(!this.selectAll))
        } else {
          Text('编辑')
            .textStyle()
            .onClick(() => {
              this.isEditMode = true;
              this.toggleSelectAll(false);
            })
        }
      }
    }
      .width('100%')
    List({ space: 8 }) {
      ForEach(this.targetItems, (item: TargetItem, index: number) => {
        ListItem() {
          TargetItemComponent({
            item,
            index: index + 0,
            isEditMode: this.isEditMode,
            focusIndex: $focusIndex,
            targetChange: $targetChange,
            checkStatus: $checkStatus,
          })
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
        .onClick(() => this.deleteTarget())
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

@Extend(Button)
function buttonStyle() {
  .width(156)
  .height(40)
  .fontSize(16)
  .fontWeight(FontWeight.Medium)
  .backgroundColor('#0D182431')
}

@Extend(Text) function textStyle() {
  .fontSize(16)
  .fontColor('#00adef')
  .lineHeight(19)
  .fontWeight(FontWeight.Regular)
}
