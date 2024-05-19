export class TargetItem {
  public text: string;
  public updateTime: Date;
  public rate: number;

  constructor(text: string) {
    this.text = text;
    this.updateTime = new Date();
    this.rate = 0;
  }

  public getFormatterDate(): string {
    const year = this.updateTime.getFullYear();
    const month = String(this.updateTime.getMonth() + 1).padStart(2, '0');
    const day = String(this.updateTime.getDate()).padStart(2, '0');

    return `${year}/${month}/${day}`;
  }

  public getRate(): string {
    return `${this.rate}%`
  }
}