//
//  SampleType4Cell.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/14.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SampleType4Cell: UITableViewCell {
    
    static let identity = "SampleType4Cell"
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellNib(SampleType4CollectionCell.self)
        }
    }
    var adapter: SampleType4Adapter!
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
