//
//  SSTableDataSource.swift
//  Gas Stations
//
//  Created by WildBoar on 04.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit

extension StationStatisticViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gasStationStatistic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statisticTableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! StationStatisticTableViewCell
        let station = gasStationStatistic[indexPath.row]
        cell.stationName.text = station.stationName
        cell.stationAddresss.text = station.stationAdress
        cell.fuelProvider.text = station.stationFuelProvider
        cell.fuelPrice.text = station.fuelPrice
        cell.typeOfFuel.text = station.fuelType
        cell.gallonsCount.text = station.gallonQuantity
        cell.userCount.text = String(station.users.count)
        return cell
    }
    
}
