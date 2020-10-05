//
//  PopoverPresentationControllerDelegate.swift
//  Gas Stations
//
//  Created by WildBoar on 03.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit

extension MapAddGasStationViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        gasStationMapKit.deselectAnnotation(gasStationMapKit.selectedAnnotations.first!, animated: true)
    }
}
