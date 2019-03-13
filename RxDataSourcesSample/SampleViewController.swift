//
//  SampleViewController.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2018/07/23.
//  Copyright © 2018年 田中 厳貴. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class SampleViewController: UIViewController {
    
    private var adapter: SampleAdapter!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var type1Button: UIButton!
    @IBOutlet weak var type2Button: UIButton!
    @IBOutlet weak var type3Button: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerCellNib(SampleType1Cell.self)
            tableView.registerCellNib(SampleType2Cell.self)
            tableView.registerCellNib(SampleType3Cell.self)
        }
    }
    
    lazy var viewModel: SampleViewModel = {
        let input = SampleViewModel.Input(
            tapType1: type1Button.rx.tap.asObservable(),
            tapType2: type2Button.rx.tap.asObservable(),
            tapType3: type3Button.rx.tap.asObservable(),
            selectSection: segmentedControl.rx.value.asObservable()
        )
        return SampleViewModel(input: input)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter = SampleAdapter(viewModel: viewModel)
        tableView.rx.setDelegate(adapter).disposed(by: disposeBag)
        bindViewModel()
        viewModel.viewDidLoad.onNext(())
    }
    
    private func bindViewModel() {
        viewModel.sampleData
        .bind(to: tableView.rx.items(dataSource: adapter.dataSource))
        .disposed(by: disposeBag)
    }
}
