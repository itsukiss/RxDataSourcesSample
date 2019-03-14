//
//  SampleType4CollectionCell.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/14.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit

class SampleType4CollectionCell: UICollectionViewCell {
    
    static let identity = "SampleType4CollectionCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    var data: SampleData? {
        didSet {
            guard let data = data else { return }
            imageView.image = data.image
            mainLabel.text = data.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.groupTableViewBackground
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
}
