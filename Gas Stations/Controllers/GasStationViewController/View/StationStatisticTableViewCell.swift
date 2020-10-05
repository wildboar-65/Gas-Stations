//
//  StationStatisticTableViewCell.swift
//  Gas Stations
//
//  Created by WildBoar on 03.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit

class StationStatisticTableViewCell: UITableViewCell {
    @IBOutlet weak var stationName: UILabel!
    
    @IBOutlet weak var stationAddresss: UILabel!
    
    @IBOutlet weak var fuelProvider: UILabel!
    @IBOutlet weak var gallonsCount: UILabel!
    @IBOutlet weak var typeOfFuel: UILabel!
    @IBOutlet weak var fuelPrice: UILabel!
    @IBOutlet weak var userCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
