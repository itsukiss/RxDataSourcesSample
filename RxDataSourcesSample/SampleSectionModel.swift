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
    case other(data: SampleData)
    var identity: String {
        switch self {
        case .sample1(let data):
            return data.id
        case .other(let data):
            return data.id
        }
    }
    
    static func == (lhs: SampleSectionItem, rhs: SampleSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}

final class SampleAdapter: NSObject, UITableViewDelegate {
    
    private weak var viewModel: SampleViewModel?
    
    init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
    }
    
    lazy var dataSource = RxTableViewSectionedAnimatedDataSource<SampleSectionModel>.init(animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .none, deleteAnimation: .fade), configureCell: { [weak self] dataSource, table, indexPath, item in
        guard let me = self else { return UITableViewCell() }
        switch item {
        case .sample1(let data):
            let cell = table.dequeueReusableCell(withIdentifier: "SampleType1Cell", for: indexPath) as! SampleType1Cell
            cell.data = data
            let _ = cell.rx.tapGesture
                .subscribe(onNext: { _ in
                    // ---Debug Code---（セルタップ時の挙動をここに書く）
                    print(indexPath.row)
                    let mirror = Mirror(reflecting: data)
                    print(type(of: data))
                    mirror.children.forEach { print("\($0 ?? "unknown"): \($1)") }
                }, onCompleted: {
                    print("\(indexPath.row): is Reused")
                    // ---Debug Code---
                })
            return cell
        case .other(let data):
            let cell = table.dequeueReusableCell(withIdentifier: "SampleType2Cell", for: indexPath) as! SampleType2Cell
            cell.data = data
            let _ = cell.rx.tapGesture
                .subscribe(onNext: { _ in
                    // ---Debug Code---（セルタップ時の挙動をここに書く）
                    print(indexPath.row)
                }, onCompleted: {
                    print("\(indexPath.row): is Reused")
                    // ---Debug Code---
                })
            return cell
        }
    })
}
