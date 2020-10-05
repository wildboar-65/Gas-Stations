//
//  GSLTableViewDelegates.swift
//  Gas Stations
//
//  Created by WildBoar on 04.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import RealmSwift

extension GasStationListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let gasStationKey = gasStations[indexPath.row].keyStation
            let realm = try! Realm()
            let deletedObject = realm.objects(LocalGasStation.self).filter("keyStation = '\(gasStationKey!)'").first
            try! realm.write{
                realm.delete(deletedObject!)
            }
            gasStations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            deleteUser(stationKey: gasStationKey!)
            if gasStations.isEmpty {
                editStaionOutlet.isSelected = false
            }
        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let gasStation = gasStations[sourceIndexPath.row]
        gasStations.remove(at: sourceIndexPath.row)
        gasStations.insert(gasStation, at: destinationIndexPath.row)
    }
}
