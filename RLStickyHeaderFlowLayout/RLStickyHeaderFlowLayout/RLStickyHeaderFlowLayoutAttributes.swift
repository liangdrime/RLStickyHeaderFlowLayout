//
//  RLStickyHeaderFlowLayoutAttributes.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import Foundation
import UIKit

open class RLStickyHeaderFlowLayoutAttributes: UICollectionViewLayoutAttributes {
    open var progressiveness: CGFloat! = 0
    
    override open var zIndex: Int {
        get {
            return super.zIndex
        }
        set {
            super.zIndex = newValue
            transform3D = CATransform3DMakeTranslation(0, 0, newValue == 1 ? -1 : 0)
        }
    }
    
    override open func copy(with zone: NSZone?) -> Any {
        let copy:RLStickyHeaderFlowLayoutAttributes = super.copy(with: zone) as! RLStickyHeaderFlowLayoutAttributes
        copy.progressiveness = progressiveness
        return copy
    }
}
