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
        
        reloadLayout()
        collectionView?.register(headerNib, forSupplementaryViewOfKind: RLStickyHeaderParallaxHeader, withReuseIdentifier: "header")
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        reloadLayout()
    }
    
    func reloadLayout() {
        let layout = collectionViewLayout as? RLStickyHeaderFlowLayout
        
        if (layout != nil) {
            layout!.itemSize = CGSize(view.frame.size.width, layout!.itemSize.height)
            
            layout!.parallaxHeaderReferenceSize = CGSize(view.frame.size.width, parallaxHeaderReferenceHeight)
            
            layout!.parallaxHeaderMinimumReferenceSize = CGSize(view.frame.size.width, parallaxHeaderMinimumReferenceHeight)
            layout!.parallaxHeaderAlwaysOnTop = parallaxHeaderAlwaysOnTop
            
            // If we want to disable the sticky header effect
            layout!.disableStickyHeaders = disableStickyHeaders
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RLCollectionCell
        
        let obj = sections[indexPath.section]
        let values = Array(obj.values)
        
        if sections.count == 1 {
            cell!.textLabel!.text = "\(values[indexPath.item])\(indexPath.item)"
        }else {
            cell!.textLabel!.text = values[indexPath.item]
        }
        
        
        return cell!
    }
    

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath as IndexPath) as? RLSectionHeader
            
            let obj = sections[indexPath.section]
            let values = Array(obj.keys)
            
            header!.textLabel!.text = values[indexPath.item]
            
            return header!
            
        } else if kind == RLStickyHeaderParallaxHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath as IndexPath)
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hit cell at \(indexPath).....")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
