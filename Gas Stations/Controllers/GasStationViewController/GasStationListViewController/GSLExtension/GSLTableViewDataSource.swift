//
//  GSLTableViewDataSource.swift
//  Gas Stations
//
//  Created by WildBoar on 04.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit

extension GasStationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gasStations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stationListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = gasStations[indexPath.row].stationName
        cell.detailTextLabel?.text = gasStations[indexPath.row].stationAdress
        return cell
    }
}
