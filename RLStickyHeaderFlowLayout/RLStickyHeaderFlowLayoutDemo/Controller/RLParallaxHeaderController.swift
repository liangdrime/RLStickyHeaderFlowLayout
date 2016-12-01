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
        parallaxHeaderReferenceHeight = 200
        parallaxHeaderMinimumReferenceHeight = 0
        
        // load header
        headerNib = UINib.init(nibName: "RLParallaxHeader", bundle: Bundle.main)
        
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
    }
    
    @IBAction func reloadButtonDidPress(sender: AnyObject) {
        let indexSet = NSIndexSet.init(indexesIn: NSMakeRange(0, collectionView!.numberOfSections))
        
        collectionView!.reloadSections(indexSet as IndexSet)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
