//
//  DataStoreProtocol.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift

protocol DataStoreProtocol: class {
    func fetchAll<T:Decodable>() -> Observable<T>
}

protocol EventDataStoreProtocol: DataStoreProtocol {
    func fetchAll() -> Observable<[Event]>
}

extension EventDataStoreProtocol {
    func fetchAll<T>() -> Observable<T> where T : Decodable {
        return fetchAll()
    }
}
