//
//  RLLockedHeaderController.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/17.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

import UIKit

class RLLockedHeaderController: RLBaseCollectionController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // config the header
        self.parallaxHeaderReferenceHeight = 44
        self.parallaxHeaderMinimumReferenceHeight = 44
        
        // load header
        self.headerNib = UINib.init(nibName: "RLSearchBarHeader", bundle: NSBundle.mainBundle())
        
        // init data
        self.sections = [["Twitter":"http://twitter.com"],
                         ["Facebook":"http://facebook.com"],
                         ["Tumblr":"http://tumblr.com"],
                         ["Pinterest":"http://pinterest.com"],
                         ["Instagram":"http://instagram.com"],
                         ["Github":"http://github.com"],
                         ["Twitter":"http://twitter.com"],
                         ["Facebook":"http://facebook.com"],
                         ["Tumblr":"http://tumblr.com"],
                         ["Pinterest":"http://pinterest.com"],
                         ["Instagram":"http://instagram.com"],
                         ["Github":"http://github.com"],]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
        
        let add = UIBarButtonItem.init(title: "Add", style: .Plain, target: self, action: #selector(RLLockedHeaderController.add))
        self.navigationItem.rightBarButtonItem = add
    }
    
    func add() {
        
        weak var weakSelf = self
        self.collectionView?.performBatchUpdates({ 
            let new = [["Twitter":"http://twitter.com"],
                ["Facebook":"http://facebook.com"],
                ["Tumblr":"http://tumblr.com"],
                ["Pinterest":"http://pinterest.com"],
                ["Instagram":"http://instagram.com"],
                ["Github":"http://github.com"],
                ["Twitter":"http://twitter.com"],
                ["Facebook":"http://facebook.com"],
                ["Tumblr":"http://tumblr.com"],
                ["Pinterest":"http://pinterest.com"],
                ["Instagram":"http://instagram.com"],
                ["Github":"http://github.com"],]
            
            let set = NSMutableIndexSet.init()
            var indexPaths = [NSIndexPath]()
            
            for index in 0..<new.count {
                weakSelf!.sections.append(new[index])
                
                let indexPath = NSIndexPath.init(forItem: 0, inSection: index)
                
                indexPaths.append(indexPath)
                set.addIndex(index)
            }
            
            weakSelf!.collectionView?.insertSections(set)
            weakSelf!.collectionView?.insertItemsAtIndexPaths(indexPaths)
            }, completion: { (com: Bool) in
                
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
