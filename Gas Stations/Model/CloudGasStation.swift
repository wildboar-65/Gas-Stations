//
//  CloudGasStation.swift
//  Gas Stations
//
//  Created by WildBoar on 01.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import Foundation

struct CloudGasStation: Codable {
    var stationName: String!
    var stationFuelProvider: String!
    var stationAdress: String!
    var gallonQuantity: String!
    var fuelType: String!
    var fuelPrice: String!
    var stationLatitude: Double = 0.0
    var stationLongitude: Double = 0.0
    var users: [String:[String:String]]!
    
    var gasStationDictionary: [String: Any] {
        let data = try? JSONEncoder().encode(self)
        let dict = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) 
        return dict as! [String:Any]
    }
    init(){}
    init(dictionary: [String: Any]) {
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        self = try! JSONDecoder().decode(CloudGasStation.self, from: data!)
    }
}

