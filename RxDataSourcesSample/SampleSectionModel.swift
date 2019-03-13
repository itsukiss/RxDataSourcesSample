//
//  SampleSectionModel.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2018/07/23.
//  Copyright © 2018年 田中 厳貴. All rights reserved.
//

import RxDataSources
import RxSwift
import RxCocoa

typealias SampleSectionModel = AnimatableSectionModel<SectionID, SampleSectionItem>

enum SampleSectionItem: IdentifiableType, Equatable {
    
    case sample1(data: SampleData)
    case sample2(data: SampleData)
    case sample3(dataList: [SampleData])
    var identity: String {
        switch self {
        case .sample1(let data):
            return data.id
        case .sample2(let data):
            return data.id
        case .sample3(let dataList):
            return dataList.map { $0.id }.joined()
        }
    }
    
    static func == (lhs: SampleSectionItem, rhs: SampleSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}

final class SampleAdapter: NSObject, UITableViewDelegate {
    
    private weak var viewModel: SampleViewModel?
    var sample3DataSource: SampleType3DataSource!
    
    init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
        sample3DataSource = SampleType3DataSource(viewModel: viewModel)
    }
    
    lazy var dataSource = RxTableViewSectionedAnimatedDataSource<SampleSectionModel>.init(animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .none, deleteAnimation: .fade), configureCell: { [weak self] dataSource, table, indexPath, item in
        guard let self = self else { return UITableViewCell() }
        switch item {
        case .sample1(let data):
            let cell = table.dequeueReusableCell(withIdentifier: "SampleType1Cell", for: indexPath) as! SampleType1Cell
            cell.data = data

            return cell
        case .sample2(let data):
            let cell = table.dequeueReusableCell(withIdentifier: "SampleType2Cell", for: indexPath) as! SampleType2Cell
            cell.data = data
            return cell
        case .sample3(let dataList):
            let cell = table.dequeueReusableCell(withIdentifier: "SampleType3Cell", for: indexPath) as! SampleType3Cell
            let sectionModel = AnimatableSectionModel(model: "collectionSection1", items: dataList)
            Observable.just([sectionModel])
                .bind(to: cell.collectionView.rx.items(dataSource: self.sample3DataSource.dataSource))
                .disposed(by: cell.disposeBag)
            return cell
        }
    })
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionItem = dataSource.sectionModels[indexPath.section].items[indexPath.row]
        switch sectionItem {
        case .sample1:
            return 100
        case .sample2:
            return 150
        case .sample3(let dataList):
            return CGFloat(50 * dataList.count)
        }
    }
}

final class SampleType3DataSource: NSObject {
    
    private weak var viewModel: SampleViewModel?
    
    init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
    }
    
    lazy var dataSource =
        RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, SampleData>>.init(animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .none, deleteAnimation: .fade), configureCell: { [weak self] dataSource, collection, indexPath, item in
        guard let self = self else { return UICollectionViewCell() }
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "SampleTypeCollectionCell", for: indexPath) as! SampleTypeCollectionCell
        cell.data = item
        return cell
        }, configureSupplementaryView: { (ds ,cv, kind, ip) in
            let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: ip)
            return section
    })
}
