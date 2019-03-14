//
//  BaseCollectionViewController.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/14.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class BaseCollectionViewController: UIViewController {
    
    private var adapter: BaseCollectionAdapter!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var type1Button: UIButton!
    @IBOutlet weak var type2Button: UIButton!
    @IBOutlet weak var type3Button: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellNib(BaseCollectionType1Cell.self)
            collectionView.registerCellNib(BaseCollectionType2Cell.self)
            collectionView.registerCellNib(BaseCollectionType3Cell.self)
        }
    }
    
    lazy var viewModel: SampleViewModel = {
        let input = SampleViewModel.Input(
            tapType1: type1Button.rx.tap.asObservable(),
            tapType2: type2Button.rx.tap.asObservable(),
            tapType3: type3Button.rx.tap.asObservable(),
            tapType4: type3Button.rx.tap.asObservable(),
            selectSection: segmentedControl.rx.value.asObservable()
        )
        return SampleViewModel(input: input)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter = BaseCollectionAdapter(viewModel: viewModel)
        collectionView.rx.setDelegate(adapter).disposed(by: disposeBag)
        bindViewModel()
        viewModel.viewDidLoad.onNext(())
    }
    
    private func bindViewModel() {
        viewModel.sampleData
            .bind(to: collectionView.rx.items(dataSource: adapter.dataSource))
            .disposed(by: disposeBag)
    }
}
