# swift_JieDeBuSiBai
使用swift2.0实现


# 我是怎么做到swift零基础三周完成一个企业级项目的

* 写在最前面的话

* 在写这个项目之前,本人完全没有看过`Swift`的东西,甚至连基本的语法都没有瞧上一眼.完全是凭借着oc的经验,借助万能的`google,stackoverflow`一步一步的写完这个项目的.现在正在温习基本语法,感觉很多以前在项目中不明白的东西突然就懂了,也知道当时为什么这样写,会报错,为什么加不加`?`会有这么大的区别.通过完成这个项目,不仅让我对`Swift`有了基本的了解,更重要的是,让我对编程有了重新的认识.`以下仅代表个人观点,如果某些观点跟哪位大神有冲突,希望提出批评意见,我欣然接受!同时希望各位业界大神们更多的分享好的学习方法跟经验!`

* `自己的学习方式完全反了`:

* `先用某个知识点完成某个功能,在回过头来去理解他的意思,他的基本语法.比你先搞明白他意思,再去应用他,我觉得会让你对他的理解更深,更清楚,更牢固!,至少我是这么认为的!`

* 学习oc的时候,我是从语法,到控件,到一个一个的demo按部就班的学习,花费了大量的时间跟精力,并且很多知识点,很多概念在到现在都记不住,也不熟,有时候还得回头去翻看以前的笔记.我还清楚的记得以前写过的一个demo,好像是自定义转场动画来着,当时是按照别人的代码,一步一步的敲完,最后实现了炫酷的动画效果,当时把自己高兴坏了,居然有这么炫酷的效果,可是写过之后,就过去了,当时就照着别人的代码敲,头脑里根本就没有想,`这个东西一般是用在哪种场合的,系统怎么没有提供类似的接口,代码这样写是不是合理,别人为什么要这样写,是否有更简单的办法解决这个问题`,我不知道你们在写代码的时候是个什么样的情况.以至于后来公司需要实现一个类似的功能的时候,我还花老半天在网上找例子,后来在一次整理笔记的时候,发现自己写过这样的demo,只要拿过来改改,几分钟就可以搞定的事情,结果我花了一天自己写了一个,还有`bug`.写完这个swift项目的时候我终于明白为什么我们以前做过这样的东西,为什么下次碰到同样的需求的时候,脑子里一点印象没有,`那是因为头脑里没有留下这样一个场景的印象,也就是说,这个东西一般是用在什么时候的,什么场景下使用是最合理的,最节省时间的.当时为什么需要这样去做!在写这个项目的时候,恰好证明了这一点`,why! 因为很多东西,我不会,我不懂,在编码的时候,我就会在心里问自己,`这是用来干什么的,为什么这样写不行,偏得那样写,为什么在这里要用到这个东西,通过这样反复的询问自己,不断加深了这个知识点在这个场景的应用`,以至于在写后面几个模块的时候,遇到相同的情况,脑子很快就会反应过来,`从开始的写一句出现一大堆红点,到后来自己会毫无意识的加上`?`,`!`,`??`,`as`,不断减少了出错的几率,到后来越写越顺,再到后来考虑是否除了这种写法外,还有其他更好的表达形式`.我自己也完全没有想到,短短的三周时间,就让我完成了从oc到swift的转变,开始的时候,真的很痛苦,每写完一句代码的时候,就会出现红点,根本是寸步难行,特别是`?`,`!`,`??`,`as` `as!`当时根本不知道那是什么鬼,更何况合理的使用.`但是很多东西你不懂他的意思,他的概念,并不代表你完成不了他,你只要知道他怎么使用,用到哪种场合,编译没有报错就行了.恰恰是这种思想,这种场景的应用才让你更容易的记住他,理解他!`

* `写代码之前,首先罗列出自己要做的事情,`

我们有时候会不会碰到这样的情况,代码写到一半,发现这种做法不行,又把几十行代码全删了,重新写,或者写着写着,不知道自己接下来要干嘛了,感觉自己突然死机了,大脑一片空白,我不知道你们是否出现过这样的情况没,反正在这之前,我老是犯这样的毛病后来发现一个很好的解决这种毛病的办法. `那就是写伪代码` 只有知道自己接下来要做什么,思路清晰了,写代码就快了,`只是把中文翻译成代码而已`下面举一个九宫格的例子


``// 一行允许最多4列
let maxCols = 4

// 定义按钮的宽度和高度
let buttonW :CGFloat = ScreenWidth / (CGFloat)(maxCols)
let buttonH :CGFloat = buttonW
for var i = 0; i < sqaures.count; i++  {

// 创建按钮
let button = SqaureButton(type: .Custom)

// 监听按钮的点击
button.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)

// 传递模型数据,给属性赋值
button.SqaureButtonModel = sqaures[i];
self.addSubview(button)

// 计算按钮的frame
let row:Int = i / maxCols
let  col:Int = i % maxCols
button.x = (CGFloat)(col) * buttonW
button.y = (CGFloat)(row) * buttonH
button.width = buttonW
button.height = buttonH

// 设置footer的高度

}
``


* 代码封装

* 1. `接口设计`

* 自己以前写代码老是什么都往控制器里面写,导致每一个控制器里动不动就是上百行代码,找一个方法要找老半天.所以封装一些东西是很有必要的

* 学习苹果的接口设计,你会发现其实苹果的方法调用都是有规律的,比如,单例`,UIApplication.sharedApplication()`
通知 `NSNotificationCenter.defaultCenter()`于是我在封装网络接口的时候,我是这么干的`NetWorkTools.shareNetworkTools()`,
再例如
`NSKeyedArchiver .archivedDataWithRootObject`
于是我在封装导航栏的时候我是这么干的
``navigationItem.leftBarButtonItem = UIBarButtonItem.itemWithImage("MainTagSubIcon", highlightedImageNamed: "MainTagSubIconClick" , target: self, action: "tagClick")``

最经典的
``override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell``这个方法的实现,我是这么干的

`//创建cell`

``let cell = TopCommonCell.cellwithTableView(tableView) as! TopCommonCell``

`//给模型赋值`

`` let commonModel = commonModelArry![indexPath.row]
cell.model = commonModel``

`//返回cell`

``return cell``


* 其他

1. 在写swift代码的时候,特别需要注意的是,多看方法的返回值类型,参数类型,因为或许你一不留神就,把一个`Int`类型的传给了一个`double`结果找了老半天还不知道什么原因.举一个我在项目中碰到的例子

// 2.判断file是否存在
`` var isDirectory:ObjCBool = ObjCBool(false)
let fileExists:Bool = mgr.fileExistsAtPath(self, isDirectory: &isDirectory)``

2. 有时候,你会发现,在一个类里死都敲不出,这时候你就需要想,是不是他子类的方法,例如

`dequeueReusableHeaderFooterViewWithIdentifier`这个方法只有在继承`UITableViewHeaderFooterView`才会敲出来继承UIView是敲不出来的


`` class CommentHeadView: UITableViewHeaderFooterView {

var title:String? {

didSet {

if let headerTitle = title {

titleLabel.text = headerTitle
}
}
}

class func headerViewWithTableView(tableView:UITableView) -> UIView {
var header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(ID)

if header == nil {
header = CommentHeadView()

}
return header!
} ``
``


* 3.`怎么实现oc方法,快速转化成swift方法`

* 这个时候需要找规律了,首先我们需要明白swift的参数都是放在括号类的,枚举一般都省略了前缀比如`UIImage(named: image)`那我们初始化tableViewController的时候,就可以大胆的猜想`tableViewController(style:)`
`RTNavigationController(rootViewController: vc)`当时写这个的时候还真是顺手就写出来了,不要问我为什么,我也不知道为什么!

* 有的时候,如果你在一个类里写着写着,突然报了一个该类没有初始化的的时候,你就因该检查某个变量后面有没有加`?`
* 当你定义一个Int类型的变量的时候,`你一定要初始化等于0`,不然你会发现怎么搞都没有值
*当你发现,从一个数组或者字典取出来某一个类,在使用该类给模型赋值的时候,,你明明在该类里面定义了某一个属性,可他就是报错,说没有这个属性,这个时候你一定需要用 as! 强制申明你自定义的类型,经典例子

` let cell = tableView.dequeueReusableCellWithIdentifier(RightCellIdentifier, forIndexPath: indexPath) as! RightTableViewCell`别问我是怎么知道的,还真是猜出来的

* 最蛋疼的就是数据类型转化了,现在才明白,需要转化什么类型就是在前面`加(type)(变量)`有时候少打个括号都不行

* 如果你在写一个`if`语句,或者`for`语句的时候,你需要在外部定义一个变量以便在`if` 或 `for`里面拿到值之后,再拿到后面去用,这个时候你一定记得初始化,不然总报错.就像

`` //字典转换模型
let dataobj = responseObject!["data"]
var latesArry = []
if dataobj != nil {
latesArry = CommentModel.mj_objectArrayWithKeyValuesArray(dataobj)
}``

* 如果,没有如果了!在这样写下去,估计大神看到都想吐了!

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

* 最后放一张项目gif动态图
![image](https://github.com/codeXiaoQiang/swift_JieDeBuSiBai/blob/master/3.png)



