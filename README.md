# [ZTTextField](https://github.com/zhaitong/ZTTextField)

一款简单的支持title和value互斥的附带动画效果的textField

- 可以自定义是否需要textField副标题
- 可以自定义placeholder移动动画
- 支持swift版和OC版

## How they look

![ZTTextField.gif](https://github.com/zhaitong/ZTTextField/blob/master/ZTTextFiled-HybirdDemo/ZTTextField.gif)


## How to use them

将`ZTTextFiled.h`和`ZTTextField.m`文件拖入项目中，在需要用到的VC里将TextField属性的类型改为`ZTTextFileld`即可

### Interface Builder

将xib或者storyboard中UITextField控件的module改为 `ZTTextField`，就能看到一些自定义的设置。

### Code
现在还不支持用代码创建的textFiled，仅支持IB使用
