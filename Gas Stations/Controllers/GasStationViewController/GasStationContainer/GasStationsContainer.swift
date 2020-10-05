//
//  GasStationsContainer.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class GasStationsContainer: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        barPagerSetting()
        super.viewDidLoad()
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let stationList = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: GlobalConstants.Storyboard.stationListVC)
        let stationStatistic = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: GlobalConstants.Storyboard.statisticVC)
        return [stationList, stationStatistic]
    }
    
    func barPagerSetting(){
        let darkGreen = UIColor(red: 0.114, green: 0.227, blue: 0.231, alpha: 1.0)
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = darkGreen
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 5
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .red
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
        guard changeCurrentIndex == true else { return }
        oldCell?.label.textColor = .lightGray
        newCell?.label.textColor = darkGreen
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        UserSettings.isLogIn = false
        let gasStationViewController = self.storyboard?.instantiateViewController(identifier: GlobalConstants.Storyboard.logInVC) as? UINavigationController
               self.view.window?.rootViewController = gasStationViewController
               self.view.window?.makeKeyAndVisible()
    }
    
}
