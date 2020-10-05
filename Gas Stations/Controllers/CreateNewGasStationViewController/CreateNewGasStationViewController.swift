//
//  CreateNewGasStationViewController.swift
//  Gas Stations
//
//  Created by WildBoar on 01.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import RealmSwift

protocol CreateNewGasStationProtocol {
    func updateMap()
}

class CreateNewGasStationViewController: UIViewController {
    
    var createNewGasStationProtocol: CreateNewGasStationProtocol?
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var stationNameTextField: UITextField!
    @IBOutlet weak var fuelProviderTextField: UITextField!
    @IBOutlet weak var galoonsOfFuelTextField: UITextField!
    @IBOutlet weak var fuelTypeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    var realm: Realm!
    
    @IBOutlet weak var fuelAndPriceTableView: UITableView!
    var coordinates: CLLocationCoordinate2D!
    var address: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTapped()
        priceTextField.delegate = self
        navigationController?.navigationBar.isHidden = false
        realm = try! Realm()
    }
    func textFieldСorrectness() -> String? {
    if stationNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        fuelProviderTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        galoonsOfFuelTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        fuelTypeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        priceTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
         return "All fields must be filled"
        }
        if priceTextField.text!.count < 5 {
            return "Price format must be correct"
        }
        return nil
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveInformation(_ sender: Any) {
        let textFieldError = textFieldСorrectness()
        if textFieldError != nil {
            showError(text: textFieldError)
        }else{
            errorLabel.isHidden = true
            let stationName = stationNameTextField.text!
            let stationFuelProvider = fuelProviderTextField.text!
            let stationAddress = address
            let gallonQuantity = galoonsOfFuelTextField.text!
            let fuelType = fuelTypeTextField.text!
            let fuelPrice = priceTextField.text!
            let stationLatitude = coordinates.latitude
            let stationLongitude = coordinates.longitude
            
            let stationID = (String(stationLongitude) + "-" + String(stationLatitude)).replacingOccurrences(of: ".", with: "-")
            
            let localGasStation = LocalGasStation()
            localGasStation.stationName = stationName
            localGasStation.keyStation = stationID
            localGasStation.stationFuelProvider = stationFuelProvider
            localGasStation.stationAdress = stationAddress
            localGasStation.gallonQuantity = gallonQuantity
            localGasStation.fuelType = fuelType
            localGasStation.fuelPrice = fuelPrice
            localGasStation.stationLatitude = stationLatitude
            localGasStation.stationLongitude = stationLongitude
            
            try! realm.write{
                realm.add(localGasStation)
                
            }
           
            var gasStation = CloudGasStation()
            gasStation.stationName = stationName
            gasStation.stationAdress = stationAddress
            gasStation.stationFuelProvider = stationFuelProvider
            gasStation.gallonQuantity = gallonQuantity
            gasStation.fuelType = fuelType
            gasStation.fuelPrice = fuelPrice
            gasStation.stationLatitude = stationLatitude
            gasStation.stationLongitude = stationLongitude
            gasStation.users = ["stationCreator": ["name": "user"]]
            let encodeGasStation = gasStation.gasStationDictionary
            let urlForPut = GlobalConstants.FirebaseUrl.stationUrl.urlForNewStation(newStationkey: stationID)
          
            NetworkService.alamofire.putRequest(urlString: urlForPut, parameters: encodeGasStation)
            self.dismiss(animated: true) {
                self.createNewGasStationProtocol?.updateMap()
            }
        }
    }

    func showError(text: String?){
        errorLabel.text = text
        errorLabel.isHidden = false
    }
}

