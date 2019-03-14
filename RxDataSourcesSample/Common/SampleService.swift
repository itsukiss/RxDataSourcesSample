//
//  SampleService.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/13.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation

protocol SampleServiceProtocol {
    func addSectionModel(storedData: [SampleSectionModel], sectionID: SectionID, item: SampleSectionItem) -> [SampleSectionModel]
}

class SampleService: SampleServiceProtocol {
    func addSectionModel(storedData: [SampleSectionModel], sectionID: SectionID, item: SampleSectionItem) -> [SampleSectionModel] {
        var newData = storedData
        if let index = newData.firstIndex(where: { $0.model == sectionID }) {
            let addSectionItems = newData[index].items
            let newSectionItems = addSectionItems + [item]
            newData.remove(at: index)
            newData.append(SampleSectionModel(model: sectionID, items: newSectionItems))
        } else {
            newData.append(SampleSectionModel(model: sectionID, items: [item]))
        }
        newData = newData.sorted(by: { $0.model.rawValue < $1.model.rawValue })
        return newData
    }
    
    
    
}
