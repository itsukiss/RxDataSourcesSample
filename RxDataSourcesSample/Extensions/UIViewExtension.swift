//
//  UIViewExtension.swift
//  RxDataSourcesSample
//
//  Created by 田中 厳貴 on 2018/07/31.
//  Copyright © 2018年 田中 厳貴. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIView {
    // MARK: Gesture
    func tapGesture(_ delegate: UIGestureRecognizerDelegate? = nil) -> Observable<Void> {
        objc_sync_enter(self)
        let tapGesture: UITapGestureRecognizer
        if let gesture = gestureRecognizers?.compactMap({ $0 as? UITapGestureRecognizer }).first {
            tapGesture = gesture
        } else {
            tapGesture = UITapGestureRecognizer()
            addGestureRecognizer(tapGesture)
        }
        objc_sync_exit(self)
        
        tapGesture.delegate = delegate
        return tapGesture.rx.event.map { _ in }
    }
    
    func removeTapGestures() {
        objc_sync_enter(self)
        gestureRecognizers?.compactMap({ $0 as? UITapGestureRecognizer }).forEach { tapGesture in
            removeGestureRecognizer(tapGesture)
        }
        objc_sync_exit(self)
    }
}
