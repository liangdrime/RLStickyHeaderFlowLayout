//
//  RLBaseCollectionController.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import UIKit

/**
 *  Base class for common config
 */
class RLBaseCollectionController: UICollectionViewController {
    
    var sections: [[String:String]]!
    var headerNib: UINib!
    var disableStickyHeaders: Bool! = false
    var parallaxHeaderAlwaysOnTop: Bool! = false
    var parallaxHeaderReferenceHeight: CGFloat! = 0.0
    var parallaxHeaderMinimumReferenceHeight: CGFloat! = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadLayout()
        self.collectionView?.registerNib(self.headerNib, forSupplementaryViewOfKind: RLStickyHeaderParallaxHeader, withReuseIdentifier: "header")
    }
    
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.reloadLayout()
    }
    
    func reloadLayout() {
        let layout = self.collectionViewLayout as? RLStickyHeaderFlowLayout
        
        if (layout != nil) {
            layout!.itemSize = CGSizeMake(self.view.frame.size.width, layout!.itemSize.height)
            
            layout!.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, self.parallaxHeaderReferenceHeight)
            
            layout!.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, self.parallaxHeaderMinimumReferenceHeight)
            layout!.parallaxHeaderAlwaysOnTop = self.parallaxHeaderAlwaysOnTop
            
            // If we want to disable the sticky header effect
            layout!.disableStickyHeaders = self.disableStickyHeaders
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as? RLCollectionCell
        
        let obj = self.sections[indexPath.section]
        let values = Array(obj.values)
        
        if self.sections.count == 1 {
            cell!.textLabel!.text = "\(values[indexPath.item])\(indexPath.item)"
        }else {
            cell!.textLabel!.text = values[indexPath.item]
        }
        
        
        return cell!
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            
            
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "sectionHeader", forIndexPath: indexPath) as? RLSectionHeader
            
            let obj = self.sections[indexPath.section]
            let values = Array(obj.keys)
            
            header!.textLabel!.text = values[indexPath.item]
            
            return header!
            
        } else if kind == RLStickyHeaderParallaxHeader {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath)
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("hit cell at \(indexPath).....")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
