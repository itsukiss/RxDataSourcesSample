//
//  UICollectionViewExtension.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2019/03/14.
//  Copyright © 2019年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerCellNib(_ cellClass: AnyClass) {
        guard let identifier = String(describing: type(of: cellClass)).components(separatedBy: ".").first else { return }
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
