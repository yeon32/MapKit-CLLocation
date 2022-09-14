//
//  ViewController.swift
//  MapKitCLLocation
//
//  Created by 김정연 on 2022/09/13.
//

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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
}

