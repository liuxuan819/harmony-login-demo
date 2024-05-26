@Component
export default struct CustomerButton {
  @Prop text: string

  build() {
    Text(this.text)
      .fontSize(16)
      .height(32)
      .width(96)
      .fontColor('#00adef')
  }
}
