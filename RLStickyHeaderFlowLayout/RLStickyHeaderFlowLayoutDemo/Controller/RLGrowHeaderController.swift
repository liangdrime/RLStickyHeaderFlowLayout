//
//  RLGrowHeaderController.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import UIKit

class RLGrowHeaderController: RLBaseCollectionController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // config the header
        self.parallaxHeaderReferenceHeight = 200
        self.parallaxHeaderMinimumReferenceHeight = 0
        self.disableStickyHeaders = true
        
        // load header
        self.headerNib = UINib.init(nibName: "RLGrowHeader", bundle: NSBundle.mainBundle())
        
        // init data
        self.sections = [["Twitter":"http://twitter.com"],
                         ["Facebook":"http://facebook.com"],
                         ["Tumblr":"http://tumblr.com"],
                         ["Pinterest":"http://pinterest.com"],
                         ["Instagram":"http://instagram.com"],
                         ["Github":"http://github.com"],]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
