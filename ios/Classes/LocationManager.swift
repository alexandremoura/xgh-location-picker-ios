//
//  LocationBC.swift
//  Agendamento
//
//  Created by Alexandre Rasta Moura on 07/01/21.
//

import UIKit
import CoreLocation

public protocol LocationManagerDelegate {
    func sendLocation(coordinate:CLLocationCoordinate2D?)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var delegate:LocationManagerDelegate!

    func isLocationServicesEnabled() -> Bool{
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch locationManager.authorizationStatus {
                case .authorizedAlways, .authorizedWhenInUse, .notDetermined :
                    return true
                default:
                    return false
                }
            }
        }

        return CLLocationManager.locationServicesEnabled()
    }

    func checkLocationPermission(){
        if #available(iOS 14.0, *) {

            switch locationManager.authorizationStatus {
            case .notDetermined: //Ask for permission
                locationManager.requestAlwaysAuthorization()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.getUserLocation()
                }
                break
            case .denied, .restricted: //No permission
                print("pode continuar sem localizacao")
                delegate.sendLocation(coordinate: nil)
                //MARK: - TODO
                break
            default: //Permitted
                getUserLocation()
                break
            }
        }else{
            locationManager.requestAlwaysAuthorization()
        }

    }

    func getUserLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationPermission()
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPermission()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else { return }

        print("locations = \(coordinate.latitude) \(coordinate.longitude)")
        print("pode continuar com localizacao")
        delegate.sendLocation(coordinate:coordinate)
    }
}
