//
//  PopUpWithStationInfoViewController.swift
//  Gas Stations
//
//  Created by WildBoar on 03.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import RealmSwift

protocol PopUpWithStationInfoDelegate {
    func cancelInfo(popUp: UIViewController)
    func addStation(popUp: UIViewController)
}

class PopUpWithStationInfoViewController: UIViewController {
    
    var popUpForInfoDelegate: PopUpWithStationInfoDelegate?
    
    var cloudGasStation: CloudGasStation!
    var localGasStation: LocalGasStation!
    var gasStaionKey: String!

    
    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationAddressLabel: UILabel!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addOrDeleteButtonOutlet: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewLoadSetting()
    }
        //MARK: Сheck for availability gas station in user gas station
    func isGasStationAddedToList() -> Bool{
        let realm = try! Realm()
        let result = realm.objects(LocalGasStation.self).filter("keyStation = '\(gasStaionKey!)'")
        if result.isEmpty {
            return false
        }else{
            return true
        }
        
    }
        //MARK: Some view setting for view elements
    func viewLoadSetting(){
        stationNameLabel.text = cloudGasStation.stationName
        stationAddressLabel.text = cloudGasStation.stationAdress
        fuelTypeLabel.text = cloudGasStation.fuelType
        priceLabel.text = cloudGasStation.fuelPrice
        cancelButton.layer.cornerRadius = 14.5
        addOrDeleteButtonOutlet.layer.cornerRadius = 14.5
        let isGasStationAdded = isGasStationAddedToList()
        if isGasStationAdded {
            addOrDeleteButtonOutlet.isEnabled = false
            addOrDeleteButtonOutlet.alpha = 0.6
        }else{
            addOrDeleteButtonOutlet.isEnabled = true
            addOrDeleteButtonOutlet.alpha = 1
        }
        stationNameLabel.text = cloudGasStation.stationName
        stationAddressLabel.text = cloudGasStation.stationAdress
    }
        //MARK: Close popUp
    @IBAction func cancelButtonAction(_ sender: Any) {
        popUpForInfoDelegate?.cancelInfo(popUp: self)
    }
        //MARK: Add station to user gas station list
    @IBAction func addOrDeleteButtonAction(_ sender: Any) {
        
        let url = GlobalConstants.FirebaseUrl.stationUrl.urlForNewUser(stationKey: gasStaionKey)
        NetworkService.alamofire.postRequest(urlString: url, parameters: ["name": "user"])
        
        let gasStation = LocalGasStation()
        gasStation.stationName = cloudGasStation.stationName
        gasStation.keyStation = gasStaionKey
        gasStation.stationFuelProvider = cloudGasStation.stationFuelProvider
        gasStation.stationAdress = cloudGasStation.stationAdress
        gasStation.gallonQuantity = cloudGasStation.gallonQuantity
        gasStation.fuelType = cloudGasStation.fuelType
        gasStation.fuelPrice = cloudGasStation.fuelPrice
        gasStation.stationLatitude = cloudGasStation.stationLatitude
        gasStation.stationLongitude = cloudGasStation.stationLongitude
        let realm = try! Realm()
        try! realm.write {
            realm.add(gasStation)
        }
        addOrDeleteButtonOutlet.isEnabled = false
        addOrDeleteButtonOutlet.alpha = 0.6
        popUpForInfoDelegate?.addStation(popUp: self)
    }
    
}
