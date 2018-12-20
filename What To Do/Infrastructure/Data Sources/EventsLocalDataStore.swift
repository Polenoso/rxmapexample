//
//  EventsLocalDataStore.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift

enum LocalDataStoreError: String, Swift.Error {
    case pathFileError = "Error on File Path, not found"
}

final class EventsLocalDataStore: EventDataStoreProtocol {
    
    func fetchAll() -> Observable<[Event]> {
        let eventsFileName = Environment.configuration(.eventsDataFileName)
        do {
            guard let path = Bundle.main.path(forResource: eventsFileName, ofType: "json"), let data = FileManager().contents(atPath: path) else { throw LocalDataStoreError.pathFileError }
            let content = try JSONDecoder().decode(EventContainer.self, from: data)
            let events = content.data
            return Observable.just(events)
        } catch {
            return Observable.error(error)
        }
    }
    
    func fetch(by id:String) -> Observable<Event> {
        return fetchAll().map({ (events) -> Event in
            return events.filter({$0.sharifyID == id}).first!
        })
    }
}
