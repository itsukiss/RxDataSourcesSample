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
    
    @IBOutlet weak var mainImageView: UIImageView! {
        didSet {
            mainImageView.layer.cornerRadius = 4.0
            mainImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    private let randomText = String(repeating: "abc", count: Int.random(in: 10...100))
    
    var data: SampleData? {
        didSet {
            guard let data = data else { return }
            mainTextLabel.text = data.name
            mainImageView.image = data.image
            bottomLabel.text = randomText
        }
    }
}
