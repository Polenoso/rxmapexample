//
//  EventViewModel.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

struct EventViewModel {
    let place: String
    let startDate: String
    let emoji: String
    let longitude: Double
    let latitude: Double
    let id: String
    
    init(eventData: Event) {
        id = eventData.sharifyID
        place = eventData.sharifyEventData.address ?? ""
        startDate = "\(eventData.sharifyEventData.initialDate ?? "") \(eventData.sharifyEventData.initialHour ?? "")"
        emoji = eventData.sharifyEventData.eventEmoji ?? "👻"
        longitude = Double(eventData.sharifyEventData.longitude!)!
        latitude = Double(eventData.sharifyEventData.latitude!)!
    }
}
