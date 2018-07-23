//
//  UITableViewExtension.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2018/07/23.
//  Copyright © 2018年 田中 厳貴. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCellNib(_ cellClass: AnyClass) {
        guard let identifier = String(describing: type(of: cellClass)).components(separatedBy: ".").first else { return }
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}
