import prompt from '@ohos.promptAction';
import router from '@ohos.router';
import Input from '../view/Input'

@Extend(Text)
function blueTextStyle() {
  .fontColor('#00adef')
  .fontSize(14)
  .fontWeight(FontWeight.Medium)
}

@Entry
@Component
struct Index {
  @State account: string = '';
  @State password: string = '';

  login(): void {
    if (this.account === '' || this.password === '') {
      prompt.showToast({ message: '账号或密码不能为空' });
    } else {
      router.replaceUrl({ url: 'pages/target' });
    }
  }

  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height(48)
    .width(48)
    .backgroundColor('#f1f3f5')
  }

  build() {
    Column({ space: 8 }) {
      Image($r('app.media.logo'))
        .width(78)
        .height(78)
        .margin({ top: 100 })
      Text('登陆界面')
        .fontSize(24)
        .fontColor('#333')
        .fontWeight(FontWeight.Medium)
      Text('登录账号以使用更多服务')
        .fontSize(16)
        .fontColor('#999')
        .margin({ bottom: 22 })
      Input({ text: $account, placeholder: '账号', type: InputType.Number })
      Input({ text: $password, placeholder: '密码', type: InputType.Password })
      Row() {
        Text('短信验证码登录').blueTextStyle()
        Text('忘记密码').blueTextStyle()
      }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
      Button('登录', { type: ButtonType.Capsule })
        .width('90%')
        .height(40)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#00adef')
        .margin({ top: 80, bottom: 4 })
        .onClick(() => {
          this.login();
        })
      Text('注册账号')
        .fontColor('#00adef')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
      Blank()
      Text('其他方式登录')
        .fontColor('#999')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 50, bottom: 4 })
      Row({ space: 44 }) {
        this.imageButton($r('app.media.login_method1'))
        this.imageButton($r('app.media.login_method2'))
        this.imageButton($r('app.media.login_method3'))
      }
    }
      .backgroundColor('#f1f3f5')
      .width('100%')
      .height('100%')
      .padding({
        left: 12,
        right: 12,
        bottom: 24,
      })
  }
}