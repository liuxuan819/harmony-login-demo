@Component
export default struct Rate {
  @Prop numerator: number;
  @Prop denominator: number;
  @State cycleSize: number = 60;

  getRate(): number {
    return this.denominator > 0 && this.numerator > 0 ? Math.min(this.numerator / this.denominator, 1) : 0;
  }

  getPathCommand(): string {
    const x = vp2px(this.cycleSize / 2);
    const angle = this.getRate() * Math.PI * 2;
    const sin = Math.sin(angle);
    const cos = Math.cos(angle);
    return `M${x} ${x} L${x} 0 A${x} ${x} 0 ${this.getRate() > 0.5 ? 1 : 0} 1 ${x + x * sin} ${x - x * cos} Z`;
  }

  build() {
    Stack() {
      Column() {}
      .width(this.cycleSize)
      .height(this.cycleSize)
      .borderRadius(this.cycleSize / 2)
      .backgroundColor('#f1f3f5')
      Column() {}
      .width(this.cycleSize)
      .height(this.cycleSize)
      .borderRadius(this.cycleSize / 2)
      .backgroundColor('#00adef')
      .clip(new Path({ width: '100%', height: '100%' }).commands(this.getPathCommand()))
      Column() {
        Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
          Text(this.numerator.toString())
            .fontColor('#00adef')
            .fontWeight(FontWeight.Bold)
          Text('/')
            .fontWeight(FontWeight.Bold)
          Text(this.denominator.toString())
            .fontWeight(FontWeight.Bold)
        }
        .margin(this.cycleSize * 0.1)
        .width(this.cycleSize * 0.8)
        .height(this.cycleSize * 0.8)
        .borderRadius(this.cycleSize * 0.4)
        .backgroundColor('#FFF')
      }
        .width(this.cycleSize)
        .height(this.cycleSize)
        .borderRadius(this.cycleSize / 2)
    }
      .width(this.cycleSize)
      .height(this.cycleSize)
  }
}