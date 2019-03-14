//
//  SampleType4Adapter.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/14.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import RxDataSources
import RxSwift

final class SampleType4Adapter: NSObject, UICollectionViewDelegateFlowLayout {
    
    private weak var viewModel: SampleViewModel?
    
    init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
    }
    
    lazy var dataSource =
        RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, SampleData>>.init(animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .none, deleteAnimation: .fade), configureCell: { [weak self] dataSource, collection, indexPath, item in
            guard let self = self else { return UICollectionViewCell() }
            let cell = collection.dequeueReusableCell(withReuseIdentifier: SampleType4CollectionCell.identity, for: indexPath) as! SampleType4CollectionCell
            cell.data = item
            return cell
            }, configureSupplementaryView: { (ds ,cv, kind, ip) in
                let section = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Section", for: ip)
                return section
        })
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
