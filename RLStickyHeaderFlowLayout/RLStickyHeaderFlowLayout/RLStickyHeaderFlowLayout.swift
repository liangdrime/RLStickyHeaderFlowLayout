//
//  RLStickyHeaderFlowLayout.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//
// Converted to Swift 3 by Mark R. Masterson For Ridebrain
//


import Foundation
import UIKit


/// RepresentedElementKind key for the parallax header, if you want to have a header on the top, you must registe this kind key with your `UICollectionReusableView`
public let RLStickyHeaderParallaxHeader = "RLStickyHeaderParallaxHeader"
let kHeaderZIndex = 1024


open class RLStickyHeaderFlowLayout: UICollectionViewFlowLayout {

    var _parallaxHeaderReferenceSize: CGSize! = CGSize.zero
    /// Properties:
    ///
    /// - Below four properties is used to config the parallax header and section header
    /// - If you want to have a header(eg.parallax header) on the top, you must registe this kind key `RLStickyHeaderParallaxHeader` with your `UICollectionReusableView`
    ///
    /// Set the default size of parallaxHeader by this property
    open var parallaxHeaderReferenceSize: CGSize! {
        get {
            return self._parallaxHeaderReferenceSize
        }
        set {
            self._parallaxHeaderReferenceSize = newValue
            // Make sure to update the layout
            invalidateLayout()
        }
    }
    /// Mininum size of parallaxHeader
    open var parallaxHeaderMinimumReferenceSize:CGSize! = CGSize.zero
    /// Set the parallax header on top or move when scroll, default is false
    open var parallaxHeaderAlwaysOnTop:Bool! = false
    /// If you set this property true the section header will not sticky, default is false
    open var disableStickyHeaders:Bool! = false
}


extension RLStickyHeaderFlowLayout {
    
    // Override layout methods
    override open func prepare() {
        super.prepare()
        if #available(iOS 10.0, *) {
            collectionView?.isPrefetchingEnabled = false
        } else {
            // Fallback on earlier versions
            // The Fallback is already in place - this is needed for iOS10 and Swift 3
        }
    }
    
    override open func initialLayoutAttributesForAppearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.initialLayoutAttributesForAppearingSupplementaryElement(ofKind: elementKind, at: elementIndexPath)
        if elementKind == RLStickyHeaderParallaxHeader {
            // sticky header do not need to offset
            return nil
        } else {
            // offset others
            var frame = attributes?.frame
            frame?.origin.y += parallaxHeaderReferenceSize.height
            attributes?.frame = frame!
            
        }
        return attributes
    }
    
    override open func finalLayoutAttributesForDisappearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == RLStickyHeaderParallaxHeader {
            let attribute = layoutAttributesForSupplementaryView(ofKind: elementKind, at: elementIndexPath) as? RLStickyHeaderFlowLayoutAttributes
            
            updateParallaxHeaderAttribute(attribute!)
            return attribute
        } else {
            return super.finalLayoutAttributesForDisappearingSupplementaryElement(ofKind: elementKind, at: elementIndexPath)
        }
    }
    
    override open func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        if (attributes == nil) && (elementKind == RLStickyHeaderParallaxHeader) {
            attributes = RLStickyHeaderFlowLayoutAttributes.init(forSupplementaryViewOfKind:elementKind, with:indexPath)
            
        }
        return attributes
    }
    
    // Core function: Reutrn the attributes will be used, you can custom these attributes to fit.
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if collectionView!.dataSource != nil {
            // The rect should compensate the header size
            var adjustedRect = rect
            adjustedRect.origin.y -= parallaxHeaderReferenceSize.height
            
            var allItems = [UICollectionViewLayoutAttributes]()
            let originalAttributes = super.layoutAttributesForElements(in: adjustedRect)
            //Perform a deep copy of the attributes returned from super
            for originalAttribute: UICollectionViewLayoutAttributes in originalAttributes! {
                allItems.append(originalAttribute.copy() as! UICollectionViewLayoutAttributes)
            }
            
            var headers = [Int:UICollectionViewLayoutAttributes]()
            var lastCells = [Int:UICollectionViewLayoutAttributes]()
            var visibleParallexHeader: Bool! = false
            
            for attributes in allItems {
                var frame = attributes.frame
                frame.origin.y += parallaxHeaderReferenceSize.height
                attributes.frame = frame
                
                let indexPath = attributes.indexPath
                let isHeader = attributes.representedElementKind == UICollectionElementKindSectionHeader
                let isFooter = attributes.representedElementKind == UICollectionElementKindSectionFooter
                
                if isHeader {
                    headers[indexPath.section] = attributes
                } else if isFooter {
                    // Not implemeneted
                } else {
                    let currentAttribute = lastCells[indexPath.section]
                    
                    // Get the bottom most cell of that section
                    if currentAttribute == nil || indexPath.row > currentAttribute!.indexPath.row {
                        lastCells[indexPath.section] = attributes
                    }
                    
                    if indexPath.item == 0 && indexPath.section == 0 {
                        visibleParallexHeader = true
                    }
                }
                
                if isHeader {
                    attributes.zIndex = kHeaderZIndex
                } else {
                    // For iOS 7.0, the cell zIndex should be above sticky section header
                    attributes.zIndex = 1
                }
            }
            
            
            // when the visible rect is at top of the screen, make sure we see
            // the parallex header
            if rect.minY <= 0 {
                visibleParallexHeader = true
            }
            
            if parallaxHeaderAlwaysOnTop == true {
                visibleParallexHeader = true
            }
            
            
            // This method may not be explicitly defined, default to 1
            // https://developer.apple.com/library/ios/documentation/uikit/reference/UICollectionViewDataSource_protocol/Reference/Reference.html#jumpTo_6
            // let numberOfSections = ((collectionView!.dataSource?.respondsToSelector(#selector(UICollectionViewDataSource.numberOfSectionsInCollectionView(_:)))) != nil) ?
            //    collectionView!.dataSource?.numberOfSectionsInCollectionView!(collectionView!):1
            
            
            
            // Create the attributes for the Parallex header
            if visibleParallexHeader && CGSize.zero.equalTo(parallaxHeaderReferenceSize) == false {
                let currentAttribute = RLStickyHeaderFlowLayoutAttributes.init(forSupplementaryViewOfKind:RLStickyHeaderParallaxHeader, with:IndexPath.init(index: 0))
                updateParallaxHeaderAttribute(currentAttribute)
                
                allItems.append(currentAttribute)
            }
            
            if disableStickyHeaders == false {
                for key in lastCells.keys {
                    let attributes = lastCells[key]
                    let indexPath = attributes!.indexPath
                    let indexPathKey = indexPath.section
                    
                    var header = headers[indexPathKey]
                    // CollectionView automatically removes headers not in bounds
                    if header == nil {
                        header = (layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath.init(item: 0, section: indexPath.section)))! as UICollectionViewLayoutAttributes
                        
                        if CGSize.zero.equalTo(header!.frame.size) == false {
                            allItems.append(header!)
                        }
                    }
                    if CGSize.zero.equalTo(header!.frame.size) == false {
                        updateHeaderAttributes(header!, lastCellAttributes:(lastCells[indexPathKey])!)
                    }
                }
                
            }
            
            // For debugging purpose
//            debugLayoutAttributes(allItems)
            
            return allItems
        } else {
            return nil
        }
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)!.copy() as? UICollectionViewLayoutAttributes
        var frame = attributes!.frame
        frame.origin.y += parallaxHeaderReferenceSize.height
        attributes!.frame = frame
        return attributes
    }
    
    override open var collectionViewContentSize : CGSize {
        // If not part of view hierarchy then return CGSizeZero (as in docs).
        // Call super.collectionViewContentSize can cause EXC_BAD_ACCESS when collectionView has no superview.
        if collectionView!.superview == nil {
            return CGSize.zero
        }
        var size = super.collectionViewContentSize
        size.height += parallaxHeaderReferenceSize.height
        return size
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true //Prefetch fallback
    }
    
    override class open var layoutAttributesClass : AnyClass {
        return RLStickyHeaderFlowLayoutAttributes.self
    }
    
    // MARK: Private Helper
    fileprivate func updateHeaderAttributes(_ attributes: UICollectionViewLayoutAttributes, lastCellAttributes lastAttributes: UICollectionViewLayoutAttributes) {
        let currentBounds = collectionView!.bounds
        attributes.zIndex = kHeaderZIndex
        attributes.isHidden = false
        
        var origin = attributes.frame.origin
        
        let sectionMaxY = lastAttributes.frame.maxY - attributes.frame.size.height
        var y = currentBounds.maxY - currentBounds.size.height + collectionView!.contentInset.top
        
        if parallaxHeaderAlwaysOnTop! {
            y += parallaxHeaderMinimumReferenceSize.height
        }
        
        let maxY = fmin(fmax(y, attributes.frame.origin.y), sectionMaxY)
        
        origin.y = maxY
        
        attributes.frame = CGRect(origin: origin, size: attributes.frame.size)
        
    }
    
    /**
     *  Update the parallax header, reuslt is: orgin.y of header attribute will be changed to keep the positon of header always same
     *  `parallaxHeaderMinimumReferenceSize` determines the mininum size of the header, the height of the header will change when scrolling, and you parallax header is created through this characteristic.
     */
    fileprivate func updateParallaxHeaderAttribute(_ currentAttribute: RLStickyHeaderFlowLayoutAttributes) {
        var frame = currentAttribute.frame
        frame.size.width = parallaxHeaderReferenceSize.width
        frame.size.height = parallaxHeaderReferenceSize.height
        
        let bounds = collectionView!.bounds
        let maxY = frame.maxY
        
        // make sure the frame won't be negative values
        var y = fmin(maxY - parallaxHeaderMinimumReferenceSize.height, bounds.origin.y + collectionView!.contentInset.top)
        let height = fmax(0, -y + maxY)
        
        
        let maxHeight = parallaxHeaderReferenceSize.height
        let minHeight = parallaxHeaderMinimumReferenceSize.height
        let progressiveness = (height - minHeight)/(maxHeight - minHeight)
        currentAttribute.progressiveness = progressiveness
        
        
        // if zIndex < 0 would prevents tap from recognized right under navigation bar
        currentAttribute.zIndex = 0
        
        // When parallaxHeaderAlwaysOnTop is enabled, we will check when we should update the y position
        if parallaxHeaderAlwaysOnTop && height <= parallaxHeaderMinimumReferenceSize.height {
            let insetTop = collectionView!.contentInset.top
            // Always stick to top but under the nav bar
            y = collectionView!.contentOffset.y + insetTop
            currentAttribute.zIndex = 2000
        }
        
        currentAttribute.frame = CGRect(x: frame.origin.x, y: y, width: frame.size.width, height: height)
    }
    
    // MARK: Debuging
    fileprivate func debugLayoutAttributes(_ layoutAttributes: [UICollectionViewLayoutAttributes]) {
        var hasInvalid: Bool = false
        for attr in layoutAttributes {
            hasInvalid = !attr.isValid()
            if (hasInvalid) {
                break
            }
        }
        
        if (hasInvalid) {
            print("[Invalid] RLStickyHeaderFlowLayout: \(layoutAttributes)")
        }
    }

}

// MARK: Debuging
extension UICollectionViewLayoutAttributes {
    
    override open var description:String {

        let indexPath = value(forKey: "indexPath")
        let zIndex = value(forKey: "zIndex")
        let representedElementKind = value(forKey: "representedElementKind")
        let frame = value(forKey: "frame")
        
        
        return "RLStickyHeaderFlowLayout indexPath: \(indexPath) zIndex: \(zIndex) valid: \(isValid()) kind: \(representedElementKind) frame:\(frame)"
    }
    
    func isValid() -> Bool {
        switch (representedElementCategory) {
        case .cell:
            if zIndex != 1 {
                return false
            }
            return true
        case .supplementaryView:
            if representedElementKind == RLStickyHeaderParallaxHeader {
                return true
            } else if zIndex < 1024 {
                return false
            }
            return true
        default:
            return true
        }
    }
}




