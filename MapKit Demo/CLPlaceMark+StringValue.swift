//
//  CLPlaceMark+StringValue.swift
//  MapKit Demo
//
//  Created by Nataliia Shusta on 03/06/2023.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    
    func stringValue() -> String {
        
        var components: [String] = []
        
        if let name = self.name {
            components.append(name)
        }
        
        if let thoroughfare = self.thoroughfare {
            components.append(thoroughfare)
        }
        
        if let subThoroughfare = self.subThoroughfare {
            components.append(subThoroughfare)
        }
        
        if let locality = self.locality {
            components.append(locality)
        }
        
        if let administrativeArea = self.administrativeArea {
            components.append(administrativeArea)
        }
        
        if let postalCode = self.postalCode {
            components.append(postalCode)
        }
        
        if let country = self.country {
            components.append(country)
        }
        
        return components.joined(separator: ", ")
    }
}
