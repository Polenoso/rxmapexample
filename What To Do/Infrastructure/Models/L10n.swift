//
//  L10n.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

struct L10n {
    let eng: String?
    let cat: String?
    let esp: String?
}

extension L10n: Codable {
    
    enum CodingKeys: String, CodingKey {
        case eng = "ENG"
        case cat = "CAT"
        case esp = "ESP"
    }
}

extension L10n {
    
    func localized() -> String? {
        let locale = Locale.current.languageCode
        switch locale {
        case "en":
            return self.eng
        case "es":
            return self.esp
        case "cat":
            return self.cat
        default:
            return self.eng
        }
    }
}
