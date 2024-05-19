@Component
export default struct Input {
  @State placeholder: string = '';
  @State type: InputType = InputType.Normal;
  @Link text: string;
  @State maxLength: number = 12;

  build() {
    TextInput({ placeholder: this.placeholder })
      .type(this.type)
      .maxLength(this.maxLength)
      .height(45)
      .fontSize(18)
      .width('100%')
      .margin({ top: 4 })
      .onChange((value: string) => {
        this.text = value;
      })
  }
}