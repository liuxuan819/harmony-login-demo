import { getFormattedDateByTimestamp } from './common';
export class TargetItem {
  public text: string;
  public updateTime: number;
  public rate: number;

  constructor(text: string) {
    this.text = text;
    this.updateTime = Date.now();
    this.rate = 0;
  }

  public getFormatterDate(): string {
    return getFormattedDateByTimestamp(this.updateTime)
  }

  public getRate(): string {
    return `${this.rate}%`
  }
}