//
//  Date+Tools.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

enum DateError: String, Swift.Error {
    case invalidDateString = "Date String Invalid"
}

enum AppDateFormats: String {
    case displayedDate = "YYYY-MM-dd"
    case displayedTime = "HH:mm"
}

extension Date {
    
    static func dateFromString(_ string: String?, format:AppDateFormats) throws -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = format.rawValue
        guard let date = dateFormatter.date(from: string ?? "") else {
            throw DateError.invalidDateString
        }
        return date
    }
}
