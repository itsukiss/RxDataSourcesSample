//
//  SampleDataProvider.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/13.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit

protocol SampleDataProviderProtocol: AnyObject {
    func getMockData(count: Int) -> [SampleData]
}

class SampleDataProvider: SampleDataProviderProtocol {
    func getMockData(count: Int) -> [SampleData] {
        var dataList: [SampleData] = []
        for i in 0..<count {
            let data = SampleData(name: "collection\(i)", image: UIImage(named: "kendama"))
            dataList.append(data)
        }
        
        return dataList
    }
}
