//
//  RLGrowHeaderController.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//
// Converted to Swift 3 by Mark R. Masterson For Ridebrain
//
//

import UIKit

class RLGrowHeaderController: RLBaseCollectionController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // config the header
        parallaxHeaderReferenceHeight = 200
        parallaxHeaderMinimumReferenceHeight = 0
        disableStickyHeaders = true
        
        // load header
        headerNib = UINib.init(nibName: "RLGrowHeader", bundle: Bundle.main)
        
        // init data
        sections = [["Twitter":"http://twitter.com"],
                    ["Facebook":"http://facebook.com"],
                    ["Tumblr":"http://tumblr.com"],
                    ["Pinterest":"http://pinterest.com"],
                    ["Instagram":"http://instagram.com"],
                    ["Github":"http://github.com"],]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
