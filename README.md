# swift_JieDeBuSiBai
使用swift2.0实现


* 项目简介:

* 1.语言:`Swift2.0`

* 2.工具:Version 7.2

* 3.适配:4s~6Splus

* 4.系统:支持ios8,ios9

* 5.设计模式:`MVC` `MVVM`

* 使用到的技术点

* 项目架构:

* 项目主体架构采用网易新闻架构模式搭建整个项目,自定义`UITabBarController``UINavigationController`,`UITabBar`

* 网络层实现对`AFNetworking`的二次封装,通过单例`NetWorkTools.shareNetworkTools()`发送`get`,`post`请求

* 数据全部由模型管理.控制器通过闭包获取数据,减少控制器的束缚

* 项目主体采用`MVC`的设计模式,其中部分界面利用`MVVM`模式把一些展示逻辑封装到VM中,减少控制器的压力

* category:

* `UIImage+Extension`封装圆角图片实现对`tableView`的性能优化
* `UIView+extension`的`frame`封装减少繁琐的点语法获取尺寸,位置大小
* `UIColor+extension`分类获取随机颜色
* `UIButton+extension`分类调整内部image与titleLabel的位置
* `NSDate+Extension`判断日期
* `UIView+AutoLayout`一行代码搞定布局,减少使用第三方框架的风险
* `String+Extension`获取缓存大小,清除缓存功能的利器

* 其他:

* 闭包的基本使用,闭包作为函数的参数传值
* 通过父子控制器实现滚动标题栏的效果
* 使用`UIScrollView` 实现穿透效果
* 自定义窗口,实现透明背景
* 利用`FMDB`实现数据缓存
* 自定义不等高`cell`
* 通过`drawrect`实现自定义每个`cell`的间隙
* 多线程实现图片异步下载
* `Runtime`机制基本使用
* 使用 `pop`实现炫酷的动画效果
* 使用`DOUAudioStreamer`实现音频播放
* 使用`KRVideoPlayer`实现视频缩小,全屏播放,
* 使用 `MJRefresh`实现下拉刷新,与上拉加载更多
* 自定义字典转模型
* 九宫格的基本使用
* `tableview`的多选操作
* 设置界面封装,一行代码搞定基本数据展示
* `MenuController`-自定义实现copy,分享,点赞
* 监听`tabBar`的选中实现,新浪微博,重复点击自动刷新的效果
* 遗留的bug:

* `音频播放没有实现官方的播放效果`

* 最后放一张项目图
![image](https://github.com/codeXiaoQiang/swift_JieDeBuSiBai/blob/master/3.png)



