import { MyCustomDialog } from './MyCustomDialog'

/// 为了将dialog的初始化与与使用dialog的页面解耦
@Component
export struct CustomDialogContainer {
  @Link @Watch('onDialogToggle') controller: DialogContainerController
  dialogController?: CustomDialogController | null

  onDialogToggle() {
    if (this.controller.isOpen) {
      this.showDialog().then((data) => {
        this.controller.onDialogConfirm(data)
      })
    } else {
      this.dialogController?.close()
    }
  }

  private async showDialog(): Promise<string | undefined> {
    let resolveFunc: (value: string | undefined | PromiseLike<string | undefined>) => void = () => {
    }
    const promise = new Promise<string | undefined>(
      (resolve, _) => {
        resolveFunc = resolve
      }
    )
    this.dialogController = new CustomDialogController({
      builder: MyCustomDialog(
        {
          confirmed: (info) => {
            resolveFunc(info)
          },
          disappearCallback: () => {
            this.dialogController = null
            this.controller.isOpen = false
          }
        }
      ),
      alignment: DialogAlignment.Center,
      customStyle: true
    })
    this.dialogController?.open()
    return promise
  }

  build() {
    Column()
  }
}

export class DialogContainerController {
  isOpen: boolean = false;
  onDialogConfirm: (value: string | undefined) => void

  constructor(onConfirm: (value: string | undefined) => void) {
    this.onDialogConfirm = onConfirm
  }

  public open() {
    this.isOpen = true
  }

  public close() {
    this.isOpen = false
  }
}