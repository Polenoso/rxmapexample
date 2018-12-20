//
//  MapEventsViewController.swift
//  What To Do
//
//  Created by Aitor Pagán on 19/12/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RxCocoa
import RxSwift

class MapEventsViewController: UIViewController {
    
    private let mapView = MKMapView()
    
    private var viewModel: MapEventsViewModelProtocol?
    private var navigator: MapEventsNavigatorProtocol?
    
    let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let service = MapEventsViewModel(with: EventsLocalDataStore())
        let navigation = MapEventsNavigator()
        navigation.viewController = self
        navigator = navigation
        viewModel = service
    }
    
    override func loadView() {
        super.loadView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        bind()
        // Do any additional setup after loading the view.
    }
    
    private func setupMap() {
        mapView.showsUserLocation = false
        mapView.delegate = self
        let defaultLatitude = Double(Environment.configuration(.defaultLatitude))
        let defaultLongitude = Double(Environment.configuration(.defaultLongitude))
        let defaultCoordinate = CLLocationCoordinate2D(latitude: defaultLatitude!, longitude: defaultLongitude!)
        let defaultRegion = MKCoordinateRegion(center: defaultCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(defaultRegion, animated: true)
    }
    
    private func bind() {
        viewModel?.bind().subscribe(onSuccess: { (events) in
            self.mapView.addAnnotations(events.compactMap({ (vm) -> MapEventsAnnotation in
                let annotation = MapEventsAnnotation(vm)
                return annotation
            }))
        }, onError: nil).disposed(by: disposeBag)
    }

}

extension MapEventsViewController: MKMapViewDelegate {
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        if (fullyRendered) {
            self.bind()
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view)
        if let annotation = mapView.annotations.filter({$0.isEqual(view.annotation)}).first as? MapEventsAnnotation {
            navigator?.navigateToDetail(annotation.viewModel)
            mapView.deselectAnnotation(annotation, animated: true)
        }
    }
}
