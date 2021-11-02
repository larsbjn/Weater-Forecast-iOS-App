//
//  LocationManager.swift
//  Weather Forecast
//
//  Created by Lars Jørgensen on 02/11/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    var onLocationGranted: () -> Void = {}
    var onLocationRemoved: () -> Void = {}
    
    override init() {
        super.init()
        
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        
        manager.startUpdatingLocation()
    }
    
    func setOnLocationGranted(action: @escaping () -> Void) {
        self.onLocationGranted = action
    }
    
    func setOnLocationRemoved(action: @escaping () -> Void) {
        self.onLocationRemoved = action
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
           // Location updates are not authorized.
           manager.stopUpdatingLocation()
           return
        }
      }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedAlways , .authorizedWhenInUse:
                self.onLocationGranted()
                break
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
                break
            case .denied , .restricted:
                self.onLocationRemoved()
                break
            default:
                break
        }
    }
    
    func getLocation() -> CLLocation? {
        return manager.location
    }
}
