//
//  SampleType1Cell.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2018/07/23.
//  Copyright © 2018年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit

class SampleType1Cell: UITableViewCell {
    
    static let identity = "SampleType1Cell"
    
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
