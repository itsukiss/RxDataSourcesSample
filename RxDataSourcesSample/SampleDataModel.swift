//
//  SampleDataModel.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/13.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import RxDataSources

struct SampleData: IdentifiableType, Equatable {
    let id = UUID().uuidString
    let name: String
    let image: UIImage?
    
    var identity: String {
        return id
    }
}

enum SectionID: Int, IdentifiableType {
    case section1
    case section2
    case section3
    
    var identity: Int {
        return self.rawValue
    }
}

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
