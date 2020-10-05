//
//  AlertExtension.swift
//  Gas Stations
//
//  Created by WildBoar on 04.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit

extension UIAlertController {
    func showAlertWithOkActionOn(viewControllerForShow: UIViewController, okComplition: ((UIAlertAction) -> Void)?){
        let choseDateAlertAction = UIAlertAction(title: "OK", style: .default, handler: okComplition)
        self.addAction(choseDateAlertAction)
        viewControllerForShow.present(self, animated: true, completion: nil)
    }
}
