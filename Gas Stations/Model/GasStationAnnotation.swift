//
//  GasStationAnnotation.swift
//  Gas Stations
//
//  Created by WildBoar on 02.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import MapKit

class GasStationAnnotation: NSObject, MKAnnotation {
    var latitude: Double
    var longitude: Double
    var title: String?
    var subtitle: String?
    var annotationKey: String
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
    }
    init(latitude: Double, longitude: Double, title: String, subTitle: String, annotationKey: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.title = title
        self.subtitle = subTitle
        self.annotationKey = annotationKey
    }

}
