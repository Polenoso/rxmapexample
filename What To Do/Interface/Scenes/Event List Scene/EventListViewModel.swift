//
//  EventListViewModel.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol EventListViewModelProtocol: class {
    func bind() -> Driver<[EventViewModel]>
}

final class EventListViewModel: EventListViewModelProtocol {
    
    var store: EventDataStoreProtocol
    var driver: Driver<[EventViewModel]> = Driver.just([])
    let disposeBag = DisposeBag()
    
    init(with store: EventDataStoreProtocol) {
        self.store = store
    }
    
    func bind() -> Driver<[EventViewModel]> {
        driver = store.fetchAll()
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
            .map({ $0.sorted(by: { (e1, e2) -> Bool in
                    return e1.sharifyEventData.isRecentThan(e2.sharifyEventData)
                }).compactMap({EventViewModel(eventData: $0.sharifyEventData)})
            })
        return driver
    }
}
