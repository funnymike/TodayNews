//
//  HomeImageCell.swift
//  TodayNews
//
//  Created by ketianxiahui on 2018/12/21.
//  Copyright © 2018 Hi. All rights reserved.
//

import UIKit
import Kingfisher

class HomeImageCell: UICollectionViewCell, RegisterCellFromNib {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image = ImageList() {
        didSet {
            imageView.kf.setImage(with: URL(string: image.urlString)!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        theme_backgroundColor = "colors.cellBackgroundColor"
    }
}
