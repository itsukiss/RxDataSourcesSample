//
//  SampleType2Cell.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2018/07/23.
//  Copyright © 2018年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit

class SampleType2Cell: UITableViewCell {
    
    @IBOutlet weak var fullImageView: UIImageView!
    
    
    var data: SampleData? {
        didSet {
            guard let data = data else { return }
            fullImageView.image = data.image
        }
    }
}
