//
//  LocationMagnager.swift
//  MapKitCLLocation
//
//  Created by 김정연 on 2022/09/14.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()  //위치 정보와 관련된 이벤트를 처리하는 역할을 하는 객체
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping (CLLocation) -> Void) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()   //단 한번 요청하는가
        manager.delegate = self
        manager.startUpdatingLocation()  //지속적으로 요청하는가
    }
    
    public func resolveLocationName(with location: CLLocation, completion: @escaping ((String?)-> Void)) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current){
            placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            print (place)
            
            var name = ""
            
            if let locality = place.locality{
                name += locality
            }
            
            if let adminRegion = place.administrativeArea{
                name += ", \(adminRegion)"
            }
            
            completion(name)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
    
}
