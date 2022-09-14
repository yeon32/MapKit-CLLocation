//
//  ViewController.swift
//  MapKitCLLocation
//
//  Created by 김정연 on 2022/09/13.
//

import CoreLocation
import UIKit
import MapKit

class ViewController: UIViewController {
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        title = "Home"
        
        LocationManager.shared.getUserLocation{ [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else{
                    return
                }
                let pin = MKPointAnnotation()
                pin.coordinate = location.coordinate
                strongSelf.map.setRegion(MKCoordinateRegion(center: location.coordinate,
                span:MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)),
                                         animated: true)
                strongSelf.map.addAnnotation(pin)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(
            center: location.coordinate,
            span:MKCoordinateSpan(
                latitudeDelta: 0.7,
                longitudeDelta: 0.7
                )
            ),
                      animated: true)
        map.addAnnotation(pin)
    }
}

