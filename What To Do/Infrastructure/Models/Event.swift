//
//  Event.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

struct EventContainer {
    var data: [Event]
}

extension EventContainer: Decodable {
    
    private struct CodingKeys: CodingKey {
        var intValue: Int?
        var stringValue: String
        
        init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
        init?(stringValue: String) { self.stringValue = stringValue }
    }
    
    public init(from decoder: Decoder) throws {
        data = []
        let container = try decoder.container(keyedBy: CodingKeys.self)
        for key in container.allKeys {
            let event = try container.decode(Event.self, forKey: key)
            data.append(event)
        }
    }
}

struct Event {
    let conversationId: String
    let sharifyEventData: EventData
    let sharifyID: String
    let userType: String
}

extension Event: Codable {
    
}
