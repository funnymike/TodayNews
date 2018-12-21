//
//  DongtaiCollectionView.swift
//  TodayNews
//
//  Created by ketianxiahui on 2018/12/21.
//  Copyright © 2018 Hi. All rights reserved.
//

import UIKit

class DongtaiCollectionView: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class DongtaiCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        minimumLineSpacing = 5
        minimumInteritemSpacing = 5
    }
}
