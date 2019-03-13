//
//  SampleViewModel.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2018/07/23.
//  Copyright © 2018年 田中 厳貴. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct SampleData: IdentifiableType, Equatable {
    let id = UUID().uuidString
    let name: String
    let image: UIImage?
    
    var identity: String {
        return id
    }
}

enum SectionID: String, IdentifiableType {
    case section1
    case section2
    case section3
    
    var identity: String {
        return self.rawValue
    }
}

class SampleViewModel {
    
    var sampleData: Observable<[SampleSectionModel]> {
        return sampleDataRelay.asObservable()
    }
    
    private let sampleDataRelay = BehaviorRelay<[SampleSectionModel]>(value: [])
    
    private func fetch(shouldRefresh: Bool = false, type: SampleSectionItem) {
        var preItems = sampleDataRelay.value.first?.items ?? []
        preItems.append(type)
        let items = shouldRefresh ? [type] : preItems
        let sectionModel = SampleSectionModel(model: .section1, items: items)
        sampleDataRelay.accept([sectionModel])
    }
    
    func addType1() {
        let preItems = sampleDataRelay.value.first?.items ?? []
        let data = SampleData(name: "data\(preItems.count)", image: UIImage(named: "kendama"))
        fetch(type: .sample1(data: data))
    }
    
    func addType2() {
        let preItems = sampleDataRelay.value.first?.items ?? []
        let data = SampleData(name: "data\(preItems.count)", image: UIImage(named: "kendama"))
        fetch(type: .sample2(data: data))
    }
    
    func addType3() {
        var dataList: [SampleData] = []
        for i in 0...9 {
            let data = SampleData(name: "collection\(i)", image: UIImage(named: "kendama"))
            dataList.append(data)
        }
        
        fetch(type: .sample3(dataList: dataList))
    }
    
    func remove(model: SampleSectionItem) {
        var preItems = sampleDataRelay.value.first?.items ?? []
        guard let index = preItems.index(of: model) else { return }
        preItems.remove(at: index)
        let sectionModel = SampleSectionModel(model: .section1, items: preItems)
        sampleDataRelay.accept([sectionModel])
    }
}
