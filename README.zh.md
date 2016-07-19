# RLStickyHeaderFlowLayout
[![Carthage](https://img.shields.io/badge/Carthage-v0.1-28B9FE.svg)](https://github.com/Carthage/Carthage)
![Platforms](https://img.shields.io/badge/platforms-iOS-brightgreen.svg)
![Language](https://img.shields.io/badge/language-Swift-orange.svg)

# 前言
<br>
这个项目是[@jamztang](https://github.com/jamztang)开源项目[CSStickyHeaderFlowLayout](https://github.com/jamztang/CSStickyHeaderFlowLayout)的Swift版本
<br>
使用`UICollectionView`替换`UITableView`, 实现`UITableView`的功能。可以实现`UITableView`在plain模式下section header的悬停效果，同时增加了具有视差效果的顶部视图parallax header。
<br>




# 如何使用?

## Carthage 安装依赖
RLStickyHeaderFlowLayout 是支持[Carthage](https://github.com/Carthage/Carthage)的，只需要在自己的Cartfile中添加如下代码即可:

```
github "Roylee-ML/RLStickyHeaderFlowLayout"
```
>关于安装使用** Carthage **可以参考他人博客或者直接查看[官方文档](https://github.com/Carthage/Carthage)

<br>

## StroyBoard 中构建视图
如果在你的项目中，是用storyboard构建的collectionview。很抱歉，目前为止`RLStickyHeaderFlowLayout.framework`动态库在并不能完美的支持storyboard, 因为在storyboard中创建collectionview，没有办法直接将storyboard中的flowlayout与`RLStickyHeaderFlowLayout`类进行关联，即便强制修改storyboard代码设置flowlayout的customclass为`RLStickyHeaderFlowLayout`，也无效（会报`Unknow class RLStickyHeaderFlowLayout in interface build file` —— Storyboard无法识别这个类）。 

** 不过，现在有个替代的方案可以解决storyboard中使用`RLStickyHeaderFlowLayout`的问题： **<br>

1.首先创建`RLStickyHeaderFlowLayout`的一个子类，如下:

```
import UIKit
import RLStickyHeaderFlowLayout

class MyStickyHeaderLayout: RLStickyHeaderFlowLayout {
    
}

```
>在这里只是创建`RLStickyHeaderFlowLayout`的子类就可以，其他的什么也不用写。 如果不能直接创建`RLStickyHeaderFlowLayout`的子类，可以先创建`UICollectionViewFlowlayout`的子类，然后手动修改。

<br>

2.找到storyboard中flowlayout的custom class选项，设置成第一步创建的类`MyStickyHeaderLayout`。如果无法选择，第一步修改父类的操作可以在操作完这一步之后，再修改`MyStickyHeaderLayout`的父类为`RLStickyHeaderFlowLayout`。

![CustomClass](https://github.com/Roylee-ML/RLStickyHeaderFlowLayout/blob/master/ScreenShots/correctclass.png)
<br>
>如果你像上图中一样给storyboard中的flowlayout设置了custom class(e.g `MyStickyHeaderLayout`),然后下面的 Module 选项也不再是none了, 恭喜你，可以尽情享受`UICollectionView`实现`UITableView`效果的快感了。
<br>

# 英文文档
**英文:** [English→](https://github.com/Roylee-ML/RLStickyHeaderFlowLayout)


# 协议许可

RLStickyHeaderFlowLayout 是在 MIT 的协议许可下有效，更多内容请看 LICENSE 文件。
