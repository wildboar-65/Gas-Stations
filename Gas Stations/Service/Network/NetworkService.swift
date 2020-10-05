//
//  NetworkService.swift
//  Gas Stations
//
//  Created by WildBoar on 02.10.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import Alamofire
import Network
import SystemConfiguration

class NetworkService {
    static let alamofire = NetworkService()
    var isInternetAvaible: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func putRequest(urlString: String, parameters: [String: Any]){
        let queue = DispatchQueue.global(qos: .utility)
        let networkAvailabilityManager = NWPathMonitor()
        networkAvailabilityManager.start(queue: queue)
        networkAvailabilityManager.pathUpdateHandler = { path in
            if path.status == .satisfied {
                AF.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
                switch response.result {
                    case .success(let object):
                        print("New object added", object)
                    case .failure(let error):
                        print("Error:", error.errorDescription as Any)
                    }
                }
                networkAvailabilityManager.cancel()
            }else{
                print("No connection. Wainting")
            }
        }
    }
    func postRequest(urlString: String, parameters: [String: Any]){
        let queue = DispatchQueue.global(qos: .utility)
        let networkAvailabilityManager = NWPathMonitor()
        networkAvailabilityManager.start(queue: queue)
        networkAvailabilityManager.pathUpdateHandler = { path in
            if path.status == .satisfied {
                AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
                    switch response.result {
                    case .success(let object):
                        print("New object added", object)
                    case .failure(let error):
                        print("Error:", error.errorDescription as Any)
                    }
                }
                networkAvailabilityManager.cancel()
            }else{
                print("No connection. Wainting")
            }
        }
    }
    func getRequest(urlString: String, completion: @escaping([String:Any]?, Error?) -> ()){
        let queue = DispatchQueue.global(qos: .utility)
        let networkAvailabilityManager = NWPathMonitor()
        networkAvailabilityManager.start(queue: queue)
        networkAvailabilityManager.pathUpdateHandler = { path in
            if path.status == .satisfied {
                AF.request(urlString).validate().responseJSON { (response) in
                    switch response.result {
                    case .success(let object):
                        completion(object as? [String : Any], nil)
                    case .failure(let errro):
                        print("Error", errro)
                        completion(nil, errro)
                    }
                }
                networkAvailabilityManager.cancel()
            }else{
                print("No connection. Wainting")
            }
        }
    }
    func deleteRequest(url:String){
        let queue = DispatchQueue.global(qos: .utility)
        let networkAvailabilityManager = NWPathMonitor()
        networkAvailabilityManager.start(queue: queue)
        networkAvailabilityManager.pathUpdateHandler = { path in
            if path.status == .satisfied {
                AF.request(url, method: .delete).validate().responseJSON { (response) in
                    switch response.result {
                    case .success(let object):
                        print("object deleted", object)
                    case .failure(let error):
                        print("Error:", error.errorDescription as Any)
                    }
                }
                networkAvailabilityManager.cancel()
            }else{
                print("unsatisfied")
            }
        }
    }
}
