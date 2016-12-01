//
//  RLAlwaysOnTopHeader.swift
//  RLStickyHeaderFlowLayout
//
//  Created by Roy lee on 16/7/18.
//  Copyright © 2016年 Roy lee. All rights reserved.
//
// Converted to Swift 3 by Mark R. Masterson For Ridebrain
//
//

import UIKit

class RLAlwaysOnTopHeader: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func apply(_ _layoutAttributes: UICollectionViewLayoutAttributes) {
        
        let layoutAttributes = _layoutAttributes as? RLStickyHeaderFlowLayoutAttributes
        
        UIView.animate(withDuration: 0.2) {
            
            if layoutAttributes!.progressiveness <= 0.58 {
                self.titleLabel.alpha = 1
            } else {
                self.titleLabel.alpha = 0
            }
            
            if layoutAttributes!.progressiveness >= 1 {
                self.searchBar.alpha = 1
            } else {
                self.searchBar.alpha = 0
            }
            
        }
    }
    
}
