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
    
    private let viewModel = SampleViewModel()
    private var adapter: SampleAdapter!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerCellNib(SampleType1Cell.self)
            tableView.registerCellNib(SampleType2Cell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter = SampleAdapter(viewModel: viewModel)
        tableView.rx.setDelegate(adapter).disposed(by: disposeBag)
        viewModel.sampleData.bind(to: tableView.rx.items(dataSource: adapter.dataSource)).disposed(by: disposeBag)
    }
    
    @IBAction func addType1(_ sender: UIButton) {
        viewModel.addType1()
        #if DEBUG
        print("RxResourcesCount: \(RxSwift.Resources.total)")
        #endif
    }
    
    @IBAction func addType2(_ sender: UIButton) {
        viewModel.addType2()
    }
    
}
