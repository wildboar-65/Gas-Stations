//
//  MAGSPopUpWithStationInfoDelegate.swift
//  Gas Stations
//
//  Created by WildBoar on 05.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit


extension MapAddGasStationViewController: PopUpWithStationInfoDelegate {
    func addStation(popUp: UIViewController) {
        popUp.dismiss(animated: true, completion: nil)
        gasStationMapKit.deselectAnnotation(gasStationMapKit.selectedAnnotations.first!, animated: true)
    }
    
    func cancelInfo(popUp: UIViewController) {
        popUp.dismiss(animated: true, completion: nil)
        gasStationMapKit.deselectAnnotation(gasStationMapKit.selectedAnnotations.first!, animated: true)
    }
}
