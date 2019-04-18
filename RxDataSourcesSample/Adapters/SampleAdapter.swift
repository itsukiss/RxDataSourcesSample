//
//  SampleAdapter.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2018/07/23.
//  Copyright © 2018年 田中 厳貴. All rights reserved.
//

import RxDataSources
import RxSwift
import RxCocoa


final class SampleAdapter: NSObject, UITableViewDelegate {
    
    private var viewModel: SampleViewModel
    
    init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
    }
    
    lazy var dataSource = RxTableViewSectionedAnimatedDataSource<SampleSectionModel>.init(animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .none, deleteAnimation: .fade), configureCell: { [weak self] dataSource, table, indexPath, item in
        guard let self = self else { return UITableViewCell() }
        switch item {
        case .sample1(let data):
            let cell = table.dequeueReusableCell(withIdentifier: SampleType1Cell.identity, for: indexPath) as! SampleType1Cell
            cell.data = data

            return cell
        case .sample2(let data):
            let cell = table.dequeueReusableCell(withIdentifier: SampleType2Cell.identity, for: indexPath) as! SampleType2Cell
            cell.data = data
            return cell
        case .sample3(let dataList):
            let cell: SampleType3Cell = table.dequeueReusableCell(withIdentifier: SampleType3Cell.identity, for: indexPath) as! SampleType3Cell
            let sectionModel = AnimatableSectionModel(model: "collectionSection1", items: dataList)
            cell.adapter = SampleType3Adapter(viewModel: self.viewModel)
            cell.collectionView.rx.setDelegate(cell.adapter).disposed(by: cell.disposeBag)
            Observable.just([sectionModel])
                .bind(to: cell.collectionView.rx.items(dataSource: cell.adapter.dataSource))
                .disposed(by: cell.disposeBag)
            return cell
        case .sample4(let dataList):
            let cell: SampleType4Cell = table.dequeueReusableCell(withIdentifier: SampleType4Cell.identity, for: indexPath) as! SampleType4Cell
            let sectionModel = AnimatableSectionModel(model: "collectionSection1", items: dataList)
            cell.adapter = SampleType4Adapter(viewModel: self.viewModel)
            cell.collectionView.rx.setDelegate(cell.adapter).disposed(by: cell.disposeBag)
            Observable.just([sectionModel])
                .bind(to: cell.collectionView.rx.items(dataSource: cell.adapter.dataSource))
                .disposed(by: cell.disposeBag)
            return cell
        }
    })
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionItem = dataSource.sectionModels[indexPath.section].items[indexPath.row]
        switch sectionItem {
        case .sample1:
            return UITableViewAutomaticDimension
        case .sample2:
            return 150
        case .sample3(let dataList):
            return CGFloat(50 * dataList.count) + 1
        case .sample4:
            return 250
        }
    }
}
