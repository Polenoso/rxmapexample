//
//  EventData.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
/*
 acceptationManual : false
 address    :    Carrer dels Almogàvers, 122, 08018 Barcelona
 adminProfileImageUrl    :    https://lh4.googleusercontent.com/-ARyYaTNl2X0/AAAAAAAAAAI/AAAAAAAAAAc/shjTLByEbJw/s96-c/photo.jpg
 description    :    Pau Roca B2B Abu Sou (All night long) at The Loft!💃🏻 http://bit.ly/2PBl7X9
 eventEmoji    :    🎧
 finalDate    :    2018-12-23
 finalHour    :    06:00
 initialDate    :    2018-12-22
 initialHour    :    23:55
 latitude    :    41.397937
 localizable        {3}
 CAT    :    Pau Roca B2B Abu Sou (tota la nit) a The Loft!💃🏻 http://bit.ly/2PBl7X9
 ENG    :    Pau Roca B2B Abu Sou (All night long) at The Loft!💃🏻 http://bit.ly/2PBl7X9
 ESP    :    ¡Pau Roca B2B Abu Sou (toda la noche) en The Loft!💃🏻 http://bit.ly/2PBl7X9
 longitude    :    2.191224
 placeName    :    Razzmatazz
 provider    :    GOOGLE
 sharyPlanType    :    MUSIC
 */
public enum SharyPlanType:String, Codable, CodingKey {
    case music = "MUSIC"
    case beer = "BEER"
    case customEmoji = "CUSTOM_EMOJI"
    case coffee = "COFFEE"
    case unknown
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        guard let type = SharyPlanType(rawValue: value) else {
            self = .unknown
            return
        }
        self = type
    }
}

public struct EventData {
    let acceptationManual: Bool
    let address: String?
    let adminProfileImageUrl: String?
    let description: String?
    let eventEmoji: String?
    let finalDate: String?
    let finalHour: String?
    let initialDate: String?
    let initialHour: String?
    let latitude: String?
    let longitude: String?
    let localizable: L10n?
    let placeName: String?
    let provider: String?
    let sharyPlanType: SharyPlanType?
}

extension EventData: Codable {
    //No Coding key definition needed because of same properties names
}

extension EventData {
    
    func isRecentThan(_ event: EventData) -> Bool {
        do {
            let selfDate = try Date.dateFromString(self.initialDate, format: .displayedDate)
            let selfHour = try Date.dateFromString(self.initialHour, format: .displayedTime)
            let otherDate = try Date.dateFromString(event.initialDate, format: .displayedDate)
            let otherHour = try Date.dateFromString(event.initialHour, format: .displayedTime)
            
            return selfDate == otherDate ? selfHour <= otherHour : selfDate < otherDate
        } catch {
            return false
        }
    }
}
