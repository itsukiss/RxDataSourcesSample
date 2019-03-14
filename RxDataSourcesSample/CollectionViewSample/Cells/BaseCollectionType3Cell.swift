//
//  BaseCollectionType3Cell.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/14.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionType3Cell: UICollectionViewCell {
    
    static let identity = "BaseCollectionType3Cell"
    
    @IBOutlet weak var fullImageView: UIImageView!
    
    
    var data: SampleData? {
        didSet {
            guard let data = data else { return }
            fullImageView.image = data.image
        }
    }
}
