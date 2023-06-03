//
//  ViewController.swift
//  MapKit Demo
//
//  Created by Nataliia Shusta on 03/06/2023.
//

import UIKit
import MapKit
import CoreLocation

final class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var textField: UITextField!
    
    private lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    //MARK: -  Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    //MARK: - IBActions
    
    @IBAction func ButtonPressed(_ sender: Any) {
        guard let currentLocation = locationManager.location else { return }
        
        currentLocation.lookUpLocationName { (name) in
            self.updateLocationOnMap(to: currentLocation, with: name)
        }
    }
    
    //MARK: - Private methods
    
    private func updateLocationOnMap(to location: CLLocation, with title: String?) {
        
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        mapView.removeAnnotations(self.mapView.annotations)
        mapView.addAnnotation(point)
        
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(viewRegion, animated: true)
    }
    
    private func updatePlaceMark(to address: String) {
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemark = placemarks?.first,
                let location = placemark.location
            else { return }
            
            self.updateLocationOnMap(to: location, with: placemark.stringValue())
        }
    }
}

//MARK: - Location Manager Delegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        location.lookUpLocationName { (name) in
            self.updateLocationOnMap(to: location, with: name)
        }
    }
}

//MARK: -  Text Field Delegate

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let address = textField.text else { return false }
        textField.resignFirstResponder()

        updatePlaceMark(to: address)
        return true
    }
}

