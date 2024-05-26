@CustomDialog
export default struct Dialog {
  @State text: string = '';
  private controller: CustomDialogController;
  confirm: (value: string) => void = () => {};

  build() {
    Column() {
      Text('添加子目标')
        .width('100%')
        .fontSize(20)
        .fontWeight(FontWeight.Regular)
        .fontColor('#333')
        .textAlign(TextAlign.Start)
      TextInput({ placeholder: '请输入子目标名称'})
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 16})
        .caretColor(Color.Blue)
        .backgroundColor('#0D182431')
        .width('100%')
        .height('40%')
        .margin({ top: '6%' })
        .fontSize(16)
        .fontColor('#333')
        .onChange((text: string) => this.text = text)
      Blank()
      Row() {
        Button('取消')
          .buttonStyle()
          .onClick(() => {
            this.controller?.close();
          })
        Divider()
          .vertical(true)
        Button('确定')
          .buttonStyle()
          .onClick(() => {
            this.confirm(this.text);
            this.controller?.close();
          })
      }
      .width('70%')
      .height('10%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .padding(24)
    .height(168)
    .width('90%')
    .borderRadius(32)
    .backgroundColor(Color.White)
  }
}

@Extend(Button) function buttonStyle() {
  .fontSize(16)
  .height(32)
  .width(96)
  .backgroundColor(Color.White)
  .fontColor('#00adef')
}
