//
//  GasStationListViewController.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import RealmSwift
import XLPagerTabStrip

class GasStationListViewController: UIViewController {
    var gasStations: [LocalGasStation]!
 
    @IBOutlet weak var addStationOutlet: UIButton!
    @IBOutlet weak var editStaionOutlet: UIButton!
    @IBOutlet weak var stationListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewSetting()
        loadedList()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        stationListTableView.isEditing = false
        editStaionOutlet.isSelected = false
    }
        //MARK: Load local gas station from Realm base
    func loadedList(){
        gasStations = []
        let realm = try! Realm()
        let gasStationss = realm.objects(LocalGasStation.self)
        for i in gasStationss {
            self.gasStations.append(i)
        }
        gasStations.reverse()
        DispatchQueue.main.async {
            self.stationListTableView.reloadData()
        }
    }
        //MARK: Some View Setting when view did load
    func viewSetting(){
        addStationOutlet.layer.cornerRadius = 30
        editStaionOutlet.layer.cornerRadius = 30
    }
        //MARK: Activate cell editing
    @IBAction func startEditTableList(_ sender: Any) {
        if !gasStations.isEmpty {
            editStaionOutlet.isSelected = !editStaionOutlet.isSelected
            stationListTableView.isEditing = !stationListTableView.isEditing
        }
    }
        //MARK: Delete user from server in deleted gas station
    func deleteUser(stationKey: String){
        let url = GlobalConstants.FirebaseUrl.stationUrl.urlForNewStation(newStationkey: stationKey)
        DispatchQueue.global().async {
            NetworkService.alamofire.getRequest(urlString: url) { (dictionary, error) in
                if let error = error {
                    print("Erorr", error.localizedDescription)
                }
                if let dict = dictionary {
                    let gasStation = CloudGasStation(dictionary: dict)
                    let user = gasStation.users.first?.key
                    let urlForDelete = GlobalConstants.FirebaseUrl.stationUrl.urlForDeleteUser(stationKey: stationKey, userID: user!)
                    NetworkService.alamofire.deleteRequest(url: urlForDelete)
                }
            }
        }
    }
}
extension GasStationListViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Gas Station")
    }
}

