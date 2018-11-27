//
//  CollectionViewCell.swift
//  TransAnimation
//
//  Created by share2glory on 2018/11/27.
//  Copyright © 2018年 WH. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var imageV = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(imageV)
        imageV.frame = self.contentView.bounds
        imageV.image = UIImage.init(named: "erha")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
