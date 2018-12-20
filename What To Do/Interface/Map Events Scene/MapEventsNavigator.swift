//
//  MapEventsNavigator.swift
//  What To Do
//
//  Created by Aitor Pagán on 20/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol MapEventsNavigatorProtocol: class {
    func navigateToDetail(_ item: EventViewModel)
}

final class MapEventsNavigator: MapEventsNavigatorProtocol {
    
    weak var viewController: MapEventsViewController?
    
    func navigateToDetail(_ item: EventViewModel) {
        let vc = EventDetailViewController()
        vc.eventId = item.id
        viewController?.present(vc, animated: true, completion: nil)
    }
}
