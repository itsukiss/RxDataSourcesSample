//
//  UITableViewCell+Rx.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2018/07/31.
//  Copyright © 2018年 田中 厳貴. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UITableViewCell {
    var tapGesture: Observable<Void> {
        return base.tapGesture().takeUntil(prepareForReuse)
    }
    
    var prepareForReuse: Observable<Void> {
        return sentMessage(#selector(base.prepareForReuse))
            .map { [weak base] _ in
                base?.removeTapGestures()
        }
    }
}
