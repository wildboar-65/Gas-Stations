//
//  GlobalConstants.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import Foundation


struct GlobalConstants {
    
    struct Storyboard {
        static let gasStationVCID = "gasStationVC"
        static let logInVC = "logIn"
        static let statisticVC = "stationStatistic"
        static let stationListVC = "gasStationList"
        static let askToCreateStationPopUp = "askToCreatePopUp"
        static let popUpWithGasStationInfo = "gasStationInfo"
    }
    struct Segue {
        static let stationParameterPopUp = "stationCreator"
    }
    struct FirebaseUrl {
        static let stationUrl = "https://gas-stations-899e9.firebaseio.com/station"
    }
    
    
}
