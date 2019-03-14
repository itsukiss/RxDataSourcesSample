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

class SampleViewModel {
    
    // input
    let viewDidLoad: AnyObserver<Void>
    let sampleData: Observable<[SampleSectionModel]>
    
    
    private let disposeBag = DisposeBag()
    
    typealias Input = (
        tapType1: Observable<Void>,
        tapType2: Observable<Void>,
        tapType3: Observable<Void>,
        tapType4: Observable<Void>,
        selectSection: Observable<Int>
    )
    
    typealias Dependency = (
        service: SampleServiceProtocol,
        provider: SampleDataProviderProtocol
    )
    
    init(input: Input, dependency: Dependency = Dependency(service: SampleService(), provider: SampleDataProvider())) {
        
        let viewDidLoadSubject = PublishSubject<Void>()
        let sampleDataRelay = BehaviorRelay<[SampleSectionModel]>(value: [])
        let selectSectionRelay = BehaviorRelay<SectionID>(value: .section1)
        
        viewDidLoad = viewDidLoadSubject.asObserver()
        sampleData = sampleDataRelay.asObservable()
        
        input.selectSection
            .map { SectionID(rawValue: $0) ?? .section1 }
            .bind(to: selectSectionRelay)
            .disposed(by: disposeBag)
        
        input.tapType1
            .map { dependency.provider.getMockData(count: 1).first }
            .flatMap { Observable.from(optional: $0) }
            .map { SampleSectionItem.sample1(data: $0) }
            .map { dependency.service.addSectionModel(storedData: sampleDataRelay.value, sectionID: selectSectionRelay.value, item: $0) }
            .bind(to: sampleDataRelay)
            .disposed(by: disposeBag)
        
        input.tapType2
            .map { dependency.provider.getMockData(count: 1).first }
            .flatMap { Observable.from(optional: $0) }
            .map { SampleSectionItem.sample2(data: $0) }
            .map { dependency.service.addSectionModel(storedData: sampleDataRelay.value, sectionID: selectSectionRelay.value, item: $0) }
            .bind(to: sampleDataRelay)
            .disposed(by: disposeBag)
        
        input.tapType3
            .map { dependency.provider.getMockData(count: 10) }
            .map { SampleSectionItem.sample3(dataList: $0) }
            .map { dependency.service.addSectionModel(storedData: sampleDataRelay.value, sectionID: selectSectionRelay.value, item: $0) }
            .bind(to: sampleDataRelay)
            .disposed(by: disposeBag)
        
        input.tapType4
            .map { dependency.provider.getMockData(count: 10) }
            .map { SampleSectionItem.sample4(dataList: $0) }
            .map { dependency.service.addSectionModel(storedData: sampleDataRelay.value, sectionID: selectSectionRelay.value, item: $0) }
            .bind(to: sampleDataRelay)
            .disposed(by: disposeBag)
        
    }
}
