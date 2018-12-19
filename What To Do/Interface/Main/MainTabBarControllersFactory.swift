//
//  MainTabBarControllersFactory.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

final class MainTabBarControllersFactory: NSObject {
    
    static func createTabBarControllers() -> [UIViewController] {
        var controllers:[UIViewController] = []
        controllers.append(createEventListController())
        return controllers
    }
    
    fileprivate static func createEventListController() -> UIViewController {
        let vc = EventListTableViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        return nc
    }
}
