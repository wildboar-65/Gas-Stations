//
//  MAGSPopUpForCreateStationDelegate.swift
//  Gas Stations
//
//  Created by WildBoar on 05.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit

extension MapAddGasStationViewController: PopUpForCreateStationDelegate {
    func cancel(popUp: UIViewController) {
        popUp.dismiss(animated: true, completion: nil)
        gasStationMapKit.deselectAnnotation(gasStationMapKit.selectedAnnotations.first!, animated: true)
    }
    
    func delete(popUp: UIViewController) {
         let annotation = gasStationMapKit.selectedAnnotations.first
        gasStationMapKit.removeAnnotation(annotation!)
        popUp.dismiss(animated: true, completion: nil)
    }
    
    func createStation(popUp: UIViewController) {
        popUp.dismiss(animated: true, completion: nil)
        gasStationMapKit.deselectAnnotation(gasStationMapKit.selectedAnnotations.first!, animated: true)
        performSegue(withIdentifier: GlobalConstants.Segue.stationParameterPopUp, sender: self)
    }
}

