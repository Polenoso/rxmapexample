//
//  MapEventsAnnotationView.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import MapKit

class MapEventsAnnotation: MKPointAnnotation {
    
    var viewModel: EventViewModel
    
    init(_ vm: EventViewModel) {
        viewModel = vm
        super.init()
        self.title = vm.emoji
        self.coordinate = CLLocationCoordinate2D(latitude: vm.latitude, longitude: vm.longitude)
    }
}

