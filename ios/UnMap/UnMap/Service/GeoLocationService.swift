//
//  GeoLocationService.swift
//  UnMap
//
//  Created by 中西直人 on 2023/10/29.
//

import Foundation
import CoreLocation
//
//class GeoLocationService: CLLocationManagerDelegate {
//    mutating func getStringLocation() -> String {
//        locationManager = CLLocationManager()
//        locationManager!.delegate = self
//
//        if !CLLocationManager.locationServicesEnabled() {
//            locationManager!.requestWhenInUseAuthorization()
//        }
//        locationManager!.startUpdatingLocation()
//        
//        return
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let newLocation = locations.last else {
//            return
//        }
//        let location:CLLocationCoordinate2D
//        = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
//        print("緯度：", location.latitude, "経度：", location.longitude)
//    }
//}
