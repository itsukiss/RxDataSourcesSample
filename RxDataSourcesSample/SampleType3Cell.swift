//
//  SampleType3Cell.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/13.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SampleType3Cell: UITableViewCell {
    
    static let identity = "SampleType3Cell"
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: SampleTypeCollectionCell.identity, bundle: nil), forCellWithReuseIdentifier: SampleTypeCollectionCell.identity)
        }
    }
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
