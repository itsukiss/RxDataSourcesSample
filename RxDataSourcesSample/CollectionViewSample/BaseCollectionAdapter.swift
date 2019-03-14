//
//  BaseCollectionAdapter.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/14.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import RxDataSources
import RxSwift
import RxCocoa

class BaseCollectionAdapter: NSObject, UICollectionViewDelegateFlowLayout {
    private weak var viewModel: SampleViewModel?
    
    init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
    }
    
    lazy var dataSource =
        RxCollectionViewSectionedAnimatedDataSource<SampleSectionModel>.init(animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .none, deleteAnimation: .fade), configureCell: { [weak self] dataSource, collection, indexPath, item in
            guard let self = self else { return UICollectionViewCell() }
            
            switch item {
            case .sample1(let data):
                let cell = collection.dequeueReusableCell(withReuseIdentifier: BaseCollectionType1Cell.identity, for: indexPath) as! BaseCollectionType1Cell
                cell.data = data
                return cell
                
            case .sample2(let data):
                let cell = collection.dequeueReusableCell(withReuseIdentifier: BaseCollectionType2Cell.identity, for: indexPath) as! BaseCollectionType2Cell
                cell.data = data
                return cell
                
            case .sample3(let dataList):
                let cell = collection.dequeueReusableCell(withReuseIdentifier: BaseCollectionType3Cell.identity, for: indexPath) as! BaseCollectionType3Cell
                cell.data = dataList.first
                return cell
            }
            
            }, configureSupplementaryView: { (ds ,cv, kind, ip) in
                let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: ip)
                return section
        })
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionItem = dataSource.sectionModels[indexPath.section].items[indexPath.row]
        let fullWidth = UIScreen.main.bounds.width
        switch sectionItem {
        case .sample1:
            return CGSize(width: fullWidth, height: 100)
        case .sample2:
            return CGSize(width: fullWidth, height: 150)
        case .sample3:
            return CGSize(width: 50, height: 50)
        }
    }
}
