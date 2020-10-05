//
//  CLLocationManagerDelegate.swift
//  Gas Stations
//
//  Created by WildBoar on 03.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

extension MapAddGasStationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let mUserLocation:CLLocation = locations[0] as CLLocation
            let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
            let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            gasStationMapKit.setRegion(mRegion, animated: true)
            locationManager.stopUpdatingLocation()
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error - locationManager: \(error.localizedDescription)")
        }


   
}
