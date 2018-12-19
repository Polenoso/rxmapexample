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
    
    init(eventData: EventData) {
        place = eventData.address ?? ""
        startDate = "\(eventData.initialDate ?? "") \(eventData.initialHour ?? "")"
        emoji = eventData.eventEmoji ?? "👻"
    }
}
