//
//  StringExtension.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import Foundation

extension String {
    
    func stringPasswordСorresponds() -> Bool {
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9]).{8,}$")
        return password.evaluate(with: self)
    }
    
    func urlForNewStation(newStationkey: String) -> String{
        return self + "/" + newStationkey + ".json"
    }
    func urlForNewUser(stationKey: String) -> String{
        return self + "/" + stationKey + "/" + "users" + ".json"
    }
    func urlForDeleteUser(stationKey: String, userID: String) -> String {
         return self + "/" + stationKey + "/" + "users/" + userID + "/" + ".json"
    }
}
