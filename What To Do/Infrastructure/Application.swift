//
//  Application.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import UIKit

final class Application: NSObject {
    
    static let shared: Application = Application()
    
    private override init() {}
    
    func configure(_ window: UIWindow) {
        
        window.makeKeyAndVisible()
    }
}
