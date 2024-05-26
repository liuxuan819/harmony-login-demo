import { getFormattedDateByTimestamp } from './common';
export class TargetItem {
  private text: string;
  private updateTime: number;
  private rate: number;

  constructor(text: string) {
    this.text = text;
    this.rate = 0;
    this.setUpdateDate();
  }

  public getText(): string {
    return this.text;
  }

  public setText(text: string) {
    if (typeof text !== 'string') {
      throw new Error('param text should be string');
    }
    this.text = text;
    this.setUpdateDate();
  }

  public getFormatterDate(): string {
    return getFormattedDateByTimestamp(this.updateTime)
  }

  private  setUpdateDate(): void {
    this.updateTime = Date.now();
  }

  public getRate(): string {
    return `${this.rate * 100}%`
  }

  public setRate(rate: number): void {
    if (typeof rate !== 'number') {
      throw new Error('param rate should be number');
    }
    if (rate < 0) {
      this.rate = 0;
    } else if (rate > 1) {
      this.rate = 1;
    } else {
      this.rate = rate;
    }
    this.setUpdateDate();
  }
}