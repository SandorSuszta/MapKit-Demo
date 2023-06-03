//
//  CLLocation+LookUp.swift
//  MapKit Demo
//
//  Created by Nataliia Shusta on 03/06/2023.
//

import Foundation
import CoreLocation

extension CLLocation {
    
    func lookUpPlaceMark(_ handler: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(self) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                handler(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                handler(nil)
            }
        }
    }
    
    
    func lookUpLocationName(_ handler: @escaping (String?) -> Void) {
        
        lookUpPlaceMark { (placemark) in
            handler(placemark?.stringValue())
        }
    }
}
