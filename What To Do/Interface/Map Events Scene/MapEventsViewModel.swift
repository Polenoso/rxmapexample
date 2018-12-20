//
//  MapEventsViewModel.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MapEventsViewModelProtocol: class {
    func bind() -> Single<[EventViewModel]>
}

final class MapEventsViewModel: MapEventsViewModelProtocol {
    
    private let dataStore: EventDataStoreProtocol
    private var disposeBag = DisposeBag()
    
    init(with dataStore: EventDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    private var driver: Single<[EventViewModel]> = Single.just([])
    
    func bind() -> Single<[EventViewModel]> { 
        driver = dataStore.fetchAll()
            .subscribeOn(MainScheduler.instance)
            .asSingle()
            .map({$0.compactMap({EventViewModel(eventData:$0)})})
        
        return driver
    }
}
