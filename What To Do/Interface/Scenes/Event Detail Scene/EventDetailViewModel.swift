//
//  EventDetailViewModel.swift
//  What To Do
//
//  Created by Aitor Pagán on 20/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol EventDetailViewModelProtocol {
    func bind(_ id:String) -> BehaviorRelay<[EventItemDetailModelView]>
}

final class EventDetailViewModel: EventDetailViewModelProtocol {
    
    var dataStore: EventDataStoreProtocol
    
    var data: BehaviorRelay<[EventItemDetailModelView]> = BehaviorRelay<[EventItemDetailModelView]>.init(value: [])
    
    init(dataStore: EventDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func bind(_ id: String) -> BehaviorRelay<[EventItemDetailModelView]> {
        dataStore.fetch(by: id).asSingle().map({ (event) -> [EventItemDetailModelView] in
            var eventData: [EventItemDetailModelView] = []
            eventData.append(EventItemDetailModelView.init(description: event.sharifyEventData.address!))
            eventData.append(EventItemDetailModelView.init(description: (event.sharifyEventData.localizable?.localized())!))
            eventData.append(EventItemDetailModelView.init(description: event.sharifyEventData.description!))
            eventData.append(EventItemDetailModelView.init(description: event.sharifyEventData.eventEmoji!))
            eventData.append(EventItemDetailModelView.init(description: "Starts: \(event.sharifyEventData.initialDate!)\(event.sharifyEventData.initialHour!)"))
            eventData.append(EventItemDetailModelView.init(description: "Ends: \(event.sharifyEventData.finalDate!)\(event.sharifyEventData.finalHour!)"))
            eventData.append(EventItemDetailModelView.init(description: (event.sharifyEventData.sharyPlanType?.rawValue)!))
            return eventData
        }).subscribe(onSuccess: { (vm) in
            self.data.accept(vm)
        }, onError: nil).dispose()
        
        return data
    }
}
