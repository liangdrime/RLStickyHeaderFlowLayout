//
//  RLStickyParallaxHeaderController.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//
// Converted to Swift 3 by Mark R. Masterson For Ridebrain
//
//

import UIKit

class RLStickyParallaxHeaderController: RLBaseCollectionController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // config the header
        parallaxHeaderReferenceHeight = 426
        parallaxHeaderMinimumReferenceHeight = 110
        parallaxHeaderAlwaysOnTop = true
        disableStickyHeaders = true
        
        // load header
        headerNib = UINib.init(nibName: "RLAlwaysOnTopHeader", bundle: Bundle.main)
        
        // init data
        var data: [String:String] = [:]
        for index in 0..<20 {
            data[String(index)] = "Song "
        }
        sections = [data]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? RLSectionHeader
            
            return header!
            
        } else if kind == RLStickyHeaderParallaxHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
