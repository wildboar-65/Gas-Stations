//
//  StationStatisticViewController.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import RealmSwift
import XLPagerTabStrip

class StationStatisticViewController: UIViewController {
    
    @IBOutlet weak var statisticTableView: UITableView!
    var gasStationStatistic = [CloudGasStation]()
    var usersCount: [String: Int]!
    let cellIdentifire = "statsCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        settingWhenViewWillApear()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(true)
            statisticTableView.isHidden = true
            gasStationStatistic = []
            statisticTableView.reloadData()
       }
      //MARK: Install cell
    func createTableCell(){
        let xib = UINib(nibName: "StatisticCell", bundle: nil)
        statisticTableView.register(xib, forCellReuseIdentifier: cellIdentifire)
    }
    func settingWhenViewWillApear(){
        if NetworkService.alamofire.isInternetAvaible{
            createTableCell()
            loadedList()
        }else{
            let alertContoller = UIAlertController(title: "Bad news", message: "Need internet connection fow showing statisctics", preferredStyle: .alert)
            alertContoller.showAlertWithOkActionOn(viewControllerForShow: self, okComplition: nil)
        }
    }
    //MARK: Load keys for local saved gas station and load from by this key station for statistic
    func loadedList(){
        let realm = try! Realm()
        var keyArrayForLoad = [String]()
            let gasStationss = realm.objects(LocalGasStation.self)
            for i in gasStationss {
                let key = i.keyStation
                keyArrayForLoad.append(key!)
            }
        getUserCountForStation(stationKeys: keyArrayForLoad)
    }
        //MARK: Load count of user for each station
    func getUserCountForStation(stationKeys: [String]){
        usersCount = [:]
        DispatchQueue.global(qos: .userInteractive).async {
            for i in stationKeys {
                let url = GlobalConstants.FirebaseUrl.stationUrl.urlForNewStation(newStationkey: i)
                NetworkService.alamofire.getRequest(urlString: url) { (dictionary, error) in
                    if let error = error {
                        print("Erorr", error.localizedDescription)
                    }
                    if let dict = dictionary {
                        let gasStation = CloudGasStation(dictionary: dict)
                        self.gasStationStatistic.append(gasStation)
                        DispatchQueue.main.async {
                            self.statisticTableView.isHidden = false
                            self.statisticTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}
extension StationStatisticViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Station Stats")
    }
    
    
}

