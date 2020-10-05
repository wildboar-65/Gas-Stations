//
//  MapAddGasStationViewController.swift
//  Gas Stations
//
//  Created by WildBoar on 30.09.2020.
//  Copyright © 2020 WildBoar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapAddGasStationViewController: UIViewController {

    @IBOutlet weak var gasStationMapKit: MKMapView!
    var locationManager: CLLocationManager!
    var selectedAnnotation: MKAnnotation!
    var addressGasStation: String!
    var stationKey: String!
    var gasStationAnnotation = [GasStationAnnotation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let lngGestureTaped = UILongPressGestureRecognizer(target: self, action: #selector(longTaped))
        gasStationMapKit.addGestureRecognizer(lngGestureTaped)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        gasStationMapKit.delegate = self
        determineCurrentLocation()
        checkInternetConnection()
    }
    func checkInternetConnection(){
        if NetworkService.alamofire.isInternetAvaible {
            loadGasStationAnnotation()
        }else{
            let alert = UIAlertController(title: "Bad news!", message: "You need interner connection for load map and gas stations", preferredStyle: .alert)
            alert.showAlertWithOkActionOn(viewControllerForShow: self, okComplition: nil)
        }
    }
        //MARK: Load gas station from base for annotation
    func loadGasStationAnnotation(){
        let url = GlobalConstants.FirebaseUrl.stationUrl + ".json"
        NetworkService.alamofire.getRequest(urlString: url) { (dict, error) in
            if let model = dict{
                for i in model {
                    let key = i.key
                    let value = i.value
                    let gasStation = CloudGasStation(dictionary: (value as! [String: Any]))
                    let annotation = GasStationAnnotation(latitude: gasStation.stationLatitude, longitude: gasStation.stationLongitude, title: gasStation.stationName, subTitle: gasStation.fuelType, annotationKey: key)
                    self.gasStationAnnotation.append(annotation)
                    DispatchQueue.main.async {
                        self.addAnnotationToMap(annotations: self.gasStationAnnotation)
                    }
                }
            }
        }
    }
    func addAnnotationToMap(annotations: [MKAnnotation]){
        gasStationMapKit.addAnnotations(annotations)
    }
        //MARK: Get real address from selected annotation
    func getAddressFromCoordinate(coordinate: CLLocationCoordinate2D){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            if let error = error{
                print("Error when generate address", error.localizedDescription)
            }
            guard let placemark = placemark?.first else {return}
            var address: String = ""
            if let country = placemark.country {
                    address += country
            }
            if let city = placemark.subAdministrativeArea {
                if address.isEmpty{
                    address += city
                }else{
                    address += ", " + city
                }
            }
            if let street = placemark.thoroughfare {
                if address.isEmpty{
                    address += street
                }else{
                    address += ", " + street
                }
            }
            if let number = placemark.subThoroughfare {
                print(number)
             if address.isEmpty{
                    address += number
                }else{
                    address += ", " + number
                }
            }
            self.addressGasStation = address
        }
    }
        //MARK: Gesture for add new annotation on the mao
    @objc func longTaped(sender: UIGestureRecognizer){
        if sender.state == .began {
            
            let locationInView = sender.location(in: gasStationMapKit)
            let locationOnMap = gasStationMapKit.convert(locationInView, toCoordinateFrom: gasStationMapKit)
            let anotation = MKPointAnnotation()
            anotation.coordinate = locationOnMap
            gasStationMapKit.addAnnotation(anotation)
            
        }
    }
        //MARK: Show popUp for new pin. Add new gas station on delete pin
    func showPopUpForNewPin(view: UIView){
        guard let popUp = storyboard?.instantiateViewController(identifier: GlobalConstants.Storyboard.askToCreateStationPopUp) as? PopUpForCreateStationViewController else {return}
        popUp.popUpForCreateDelegate = self
        popUp.modalPresentationStyle = .popover
        let popOver = popUp.popoverPresentationController
        popOver?.sourceView = view
        popOver?.permittedArrowDirections = .init([.down, .up])
        popOver?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.minY, width: 0, height: 0)
        popUp.preferredContentSize = CGSize(width: 280, height: 60)
        popOver?.delegate = self
        present(popUp, animated: true, completion: nil)
    }
        //MARK: Show PopUp for existing gas station on the map
    func showPopUpWithGasStaionInfo(view: UIView, gasStation: CloudGasStation, gasStaionKey: String){
        guard let popUp = storyboard?.instantiateViewController(identifier: GlobalConstants.Storyboard.popUpWithGasStationInfo) as? PopUpWithStationInfoViewController else {return}
        popUp.popUpForInfoDelegate = self
        popUp.gasStaionKey = gasStaionKey
        popUp.cloudGasStation = gasStation
        popUp.modalPresentationStyle = .popover
        let popOvers = popUp.popoverPresentationController
        popOvers?.sourceView = view
        popOvers?.permittedArrowDirections = .init([.down, .up])
        popOvers?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.minY, width: 0, height: 0)
        popUp.preferredContentSize = CGSize(width: 250, height: 200)
        popOvers?.delegate = self
        present(popUp, animated: true, completion: nil)
    }
        //MARK: User location
    func determineCurrentLocation() {
           locationManager = CLLocationManager()
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()

           if CLLocationManager.locationServicesEnabled() {
               locationManager.startUpdatingLocation()
            
                
           }
       }
        //MARK: Prepare segue for VC with New gas station parameters
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == GlobalConstants.Segue.stationParameterPopUp {
               let createStationVC = segue.destination as! CreateNewGasStationViewController
               createStationVC.coordinates = selectedAnnotation.coordinate
               createStationVC.address = addressGasStation
                createStationVC.createNewGasStationProtocol = self
               }
        
           
       }
    @IBAction func backToPop(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension MapAddGasStationViewController: CreateNewGasStationProtocol {
    func updateMap() {
        loadGasStationAnnotation()
    }
}

