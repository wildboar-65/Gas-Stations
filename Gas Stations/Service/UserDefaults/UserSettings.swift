//
//  UserSettings.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import Foundation

class UserSettings {
    private enum SettingsKey: String {
        case logInKey
    }
    
    static var isLogIn: Bool! {
        get{
            return UserDefaults.standard.bool(forKey: SettingsKey.logInKey.rawValue)
        }
        set{
            let defaults = UserDefaults.standard
            let key = SettingsKey.logInKey.rawValue
                if let bool = newValue {
                    defaults.set(bool, forKey: key)
                }else{
                    defaults.removeObject(forKey: key)
                }
        }
    }
}
