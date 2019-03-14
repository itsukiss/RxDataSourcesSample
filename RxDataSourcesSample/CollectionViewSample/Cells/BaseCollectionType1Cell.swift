//
//  BaseCollectionType1Cell.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/14.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionType1Cell: UICollectionViewCell {
    static let identity = "BaseCollectionType1Cell"
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTextLabel: UILabel!
    
    var data: SampleData? {
        didSet {
            guard let data = data else { return }
            mainTextLabel.text = data.name
            mainImageView.image = data.image
        }
    }
}
