//
//  LocationManager.swift
//  MobileApp
//
//  Created by Grzegorz Gumieniak on 23/06/2021.
//


import Foundation
import CoreLocation
import Combine
final class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    private let locationManager = CLLocationManager()
    private var authorizationStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }
}
// MARK: Share location and privilages
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
    
}
// MARK: Authorization
extension LocationManager {
    private func askForTheLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    func checkIsUserShareTheAuthorization() -> Bool {
        askForTheLocation()
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            return true
        case .denied, .notDetermined, .restricted:
            return false
        default:
            fatalError()
        }
    }
}

extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
