//
//  RLParallaxHeaderController.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import UIKit

class RLParallaxHeaderController: RLBaseCollectionController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // config the header
        self.parallaxHeaderReferenceHeight = 200
        self.parallaxHeaderMinimumReferenceHeight = 0
        
        // load header
        self.headerNib = UINib.init(nibName: "RLParallaxHeader", bundle: NSBundle.mainBundle())
        
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
    }
    
    @IBAction func reloadButtonDidPress(sender: AnyObject) {
        let indexSet = NSIndexSet.init(indexesInRange: NSMakeRange(0, self.collectionView!.numberOfSections()))
        
        self.collectionView!.reloadSections(indexSet)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
