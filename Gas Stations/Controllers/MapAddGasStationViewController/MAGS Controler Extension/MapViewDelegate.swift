//
//  MapViewDelegate.swift
//  Gas Stations
//
//  Created by WildBoar on 03.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import Foundation
import MapKit

extension MapAddGasStationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
        if view.annotation is GasStationAnnotation{
            let annotation = view.annotation as! GasStationAnnotation
            stationKey = annotation.annotationKey
            let url = GlobalConstants.FirebaseUrl.stationUrl.urlForNewStation(newStationkey: stationKey)
            NetworkService.alamofire.getRequest(urlString: url){ (result, error) in
                if let error = error {
                    print("Some error", error)
                }
                if let dict = result {
                    let gasStation = CloudGasStation(dictionary: dict)
                    DispatchQueue.main.async {
                        self.showPopUpWithGasStaionInfo(view: view, gasStation: gasStation, gasStaionKey: self.stationKey)
                    }
                }
            }
        }
        if view.annotation is MKPointAnnotation {
            selectedAnnotation = view.annotation
            showPopUpForNewPin(view: view)
            getAddressFromCoordinate(coordinate: selectedAnnotation.coordinate)
    }
}
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        if annotation is GasStationAnnotation {
            let annoTationIdentifire = "gas"
            let gasView = MKAnnotationView(annotation: annotation, reuseIdentifier: annoTationIdentifire)
            gasView.image = UIImage(named: "gasAnnotation")
            gasView.frame.size = CGSize(width: 28, height: 28)
            gasView.annotation = annotation
            return gasView
        }
        return nil

}

}
