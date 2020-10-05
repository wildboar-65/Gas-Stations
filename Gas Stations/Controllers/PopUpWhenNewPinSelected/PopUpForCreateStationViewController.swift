//
//  PopUpForCreateStationViewController.swift
//  Gas Stations
//
//  Created by WildBoar on 01.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit


protocol PopUpForCreateStationDelegate {
    func cancel(popUp: UIViewController)
    func delete(popUp: UIViewController)
    func createStation(popUp: UIViewController)
}

class PopUpForCreateStationViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var createStationButton: UIButton!
    @IBOutlet weak var noInformationLabel: UILabel!
    var popUpForCreateDelegate: PopUpForCreateStationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
    }
    func viewSetting(){
        if NetworkService.alamofire.isInternetAvaible {
            createStationButton.isEnabled = true
            createStationButton.alpha = 1
            noInformationLabel.text = "No gas station by this address"
        }else{
            createStationButton.isEnabled = false
            createStationButton.alpha = 0.6
            noInformationLabel.text = "Need internet connection for create"
        }
        
        deleteButton.layer.cornerRadius = 8.5
        cancelButton.layer.cornerRadius = 8.5
        createStationButton.layer.cornerRadius = 8.5
    }
    
    @IBAction func deletePinOnMap(_ sender: Any) {
        popUpForCreateDelegate?.delete(popUp: self)
    }
    @IBAction func didsmissPopUp(_ sender: Any) {
        popUpForCreateDelegate?.cancel(popUp: self)
    }
    @IBAction func openVCToCreateNewStation(_ sender: Any) {
        popUpForCreateDelegate?.createStation(popUp: self)
    }
}
