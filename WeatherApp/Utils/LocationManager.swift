//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Admin on 2021/07/28.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location:CLLocation? = nil
    @Published var isCalled = false
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
//        self.locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//        self.locationManager.distanceFilter = kCLDistanceFilterNone
//        self.locationManager.showsBackgroundLocationIndicator = true
        self.locationManager.startUpdatingLocation()
        if isCalled == true {
        self.locationManager.stopUpdatingLocation()
        }
    }
    
}

extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            DispatchQueue.main.async {
                self.location = location

                manager.stopUpdatingLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                print("Failed to find user's location: \(error.localizedDescription)")
            }
    }
    
    

//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//
//            switch status {
//            case .notDetermined:
//                print("notDetermined")
//                manager.requestWhenInUseAuthorization()
//            case .restricted:
//                print("restricted")
//                // Inform user about the restriction
//                break
//            case .denied:
//                print("deined")
//                // The user denied the use of location services for the app or they are disabled globally in Settings.
//                // Direct them to re-enable this.
//                break
//            case .authorizedAlways, .authorizedWhenInUse:
//                print("authorized")
//                manager.requestLocation()
//            @unknown default:
//                return
//            }
//        }
    
}
