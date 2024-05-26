import { TargetItem } from '../viewModel/TargetItem'
import CustomerButton from './CustomerButton';

@Component
export default struct TargetItemComponent {
  @ObjectLink item: TargetItem;
  @State isExpand: boolean = false;
  @Prop index: number;
  @Prop isEditMode: boolean;
  @Link @Watch('focusItemChange') focusIndex: number;
  @Link targetChange: boolean;
  @Link checkStatus: boolean[];

  focusItemChange(): void {
    if (this.focusIndex !== this.index) {
      this.isExpand = false;
    }
  }

  @Builder
  renderExpandContent() {
    if (this.isExpand) {
      Row() {
        CustomerButton({ text: '取消' })
          .onClick(() => this.isExpand = false)
        CustomerButton({ text: '确定' })
          .onClick(() => {
            this.item.setRate(1);
            this.isExpand = false;
            this.targetChange = !this.targetChange;
          })
      }
      .margin({ top: '4%' })
      .width('70%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
  }


  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
        Text(this.item.getText())
          .fontColor('#333')
          .fontSize(20)
        Row() {
          Column() {
            Text(this.item.getRate())
              .fontWeight(FontWeight.Bold)
            Text(this.item.getFormatterDate())
              .fontColor('#999')
          }
          .alignItems(HorizontalAlign.End)
          if (this.isEditMode) {
            Checkbox()
              .select(this.checkStatus[this.index])
              .selectedColor('#00adef')
              .width(20)
              .margin({ left: 16 })
              .onChange((isCheck: boolean) => this.checkStatus[this.index] = isCheck)
          }
        }
      }
      this.renderExpandContent()
    }
    .width('100%')
    .borderRadius(8)
    .padding(8)
    .backgroundColor('#fff')
    .onClick(() => {
      this.isExpand = !this.isExpand;
      this.focusIndex = this.index;
    })
  }
}