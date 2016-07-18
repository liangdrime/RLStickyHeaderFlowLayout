//
//  RLStickyHeaderFlowLayoutAttributes.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import Foundation
import UIKit

public class RLStickyHeaderFlowLayoutAttributes: UICollectionViewLayoutAttributes {
    var progressiveness: CGFloat! = 0
    
    override public var zIndex: Int {
        get {
            return super.zIndex
        }
        set {
            super.zIndex = newValue
            self.transform3D = CATransform3DMakeTranslation(0, 0, newValue == 1 ? -1 : 0)
        }
    }
    
    override public func copyWithZone(zone: NSZone) -> AnyObject {
        let copy:RLStickyHeaderFlowLayoutAttributes = super.copyWithZone(zone) as! RLStickyHeaderFlowLayoutAttributes
        copy.progressiveness = self.progressiveness
        return copy
    }
}
