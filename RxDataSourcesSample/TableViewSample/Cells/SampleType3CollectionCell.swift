//
//  SampleType3CollectionCell.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/13.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit

class SampleType3CollectionCell: UICollectionViewCell {
    
    static let identity = "SampleType3CollectionCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    var data: SampleData? {
        didSet {
            guard let data = data else { return }
            imageView.image = data.image
        }
    }
}
