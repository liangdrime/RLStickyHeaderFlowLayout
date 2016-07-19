# RLStickyHeaderFlowLayout
[![Carthage](https://img.shields.io/badge/Carthage-v0.1-28B9FE.svg)](https://github.com/Carthage/Carthage)
![Platforms](https://img.shields.io/badge/platforms-iOS-brightgreen.svg)
![Language](https://img.shields.io/badge/language-Swift-orange.svg)

## Introduction
<br>
This project is a swift version of the [CSStickyHeaderFlowLayout](https://github.com/jamztang/CSStickyHeaderFlowLayout), the original address is [https://github.com/jamztang/CSStickyHeaderFlowLayout](https://github.com/jamztang/CSStickyHeaderFlowLayout)
<br>
It is for `UICollectionView` to replace `UITableView`, it can be achieved with the same features as the tableview: sticky section header, and  it can be used to complete parallax header effect
<br>




## How to use it?

### Use Carthage
RLStickyHeaderFlowLayout is available on [Carthage](https://github.com/Carthage/Carthage).  Just add the following to your Cartfile:

```
github "Roylee-ML/RLStickyHeaderFlowLayout"
```
<br>
### Use StroyBoard
If you want to use stroyboard for your collectionview. Now `RLStickyHeaderFlowLayout.framework` does not perfect support stroyboard, because it is always unable to change the custom class of flowlayout in storyboard to `RLStickyHeaderFlowLayout`. However, there is a way to solve this problem:<br>

- Create a class subclass of `RLStickyHeaderFlowLayout` like this:

```
import UIKit
import RLStickyHeaderFlowLayout

class MyStickyHeaderLayout: RLStickyHeaderFlowLayout {
    
}

```
>Just subclass from `RLStickyHeaderFlowLayout` and do nothing in this file. If can not subclass from  `RLStickyHeaderFlowLayout`, subcass from `UICollectionViewFlowlayout` and  change the superclass manually.

<br>

- Custom the class of your flowlayout in the storyboad,select the class `MyStickyHeaderLayout` created before.

![CustomClass](https://github.com/Roylee-ML/RLStickyHeaderFlowLayout/blob/master/ScreenShots/correctclass.png)
<br>
>If you can choose your layout class(e.g `MyStickyHeaderLayout`),and the Module is not none, it's sucessfull.
<br>

# License

RLStickyHeaderFlowLayout is available under the MIT license. See the LICENSE file for more info.
