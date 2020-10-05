//
//  LocalGasStation.swift
//  Gas Stations
//
//  Created by WildBoar on 01.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import Foundation
import RealmSwift

class LocalGasStation: Object {
    @objc dynamic var stationName: String!
    @objc dynamic var keyStation: String!
    @objc dynamic var stationFuelProvider: String!
    @objc dynamic var stationAdress: String!
    @objc dynamic var gallonQuantity: String!
    @objc dynamic var fuelType: String!
    @objc dynamic var fuelPrice: String!
    @objc dynamic var stationLatitude: Double = 0.0
    @objc dynamic var stationLongitude: Double = 0.0
}
