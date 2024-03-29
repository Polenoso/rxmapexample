//
//  EventListNavigator.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
protocol EventListNavigatorProtocol {
    func navigateToDetail(_ item: EventViewModel)
}

final class EventListNavigator: EventListNavigatorProtocol {
    
    weak var viewController: EventListTableViewController?
    
    func navigateToDetail(_ item: EventViewModel) {
        let vc = EventDetailViewController()
        vc.eventId = item.id
        viewController?.present(vc, animated: true, completion: nil)
    }
}
