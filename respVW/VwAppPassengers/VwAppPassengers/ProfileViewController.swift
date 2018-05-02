//
//  ProfileViewController.swift
//  VwAppPassengers
//
//  Created by Suriel Asael on 18/04/18.
//  Copyright © 2018 Suriel Asael. All rights reserved.
//

import UIKit
import Mapbox

class MyCustomPointAnnotation: MGLPointAnnotation {
    var willUseImage: Bool = false
}

class ProfileViewController: UIViewController, MGLMapViewDelegate  {
    let point = MGLPointAnnotation()
    let URL_USER_LOGIN = "http://10.50.118.81:8000/api/login"
    var countdownTimer: Timer!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var mapB: UIView!
    
    @IBAction func buttonLogout(_ sender: UIButton) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "nombre"){
            //setting the name to label
            labelUserName.text = name
        }else{
            //send back to login view controller
        }
        
        let mapView = MGLMapView(frame: mapB.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        
        // Enable heading tracking mode so that the arrow will appear.
        mapView.userTrackingMode = .followWithHeading
        
        // Enable the permanent heading indicator, which will appear when the tracking mode is not `.followWithHeading`.
        mapView.showsUserHeadingIndicator = true
        
        mapB.addSubview(mapView)
        
        mapView.delegate = self
        
        // Declare the marker `hello` and set its coordinates, title, and subtitle.
        let station1 = MGLPointAnnotation()
        station1.coordinate = CLLocationCoordinate2D(latitude: 19.127080499678105, longitude: -98.26139961596073)
        station1.title = "Nave 31"
        station1.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station1)
        
        let station2 = MGLPointAnnotation()
        station2.coordinate = CLLocationCoordinate2D(latitude: 19.127956029601044, longitude: -98.2584424067154)
        station2.title = "Nave 82 a NSO"
        station2.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station2)
        
        let station3 = MGLPointAnnotation()
        station3.coordinate = CLLocationCoordinate2D(latitude: 19.13089940000003, longitude: -98.25923230000001)
        station3.title = "Nave 80 a NSO"
        station3.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station3)
        
        let station4 = MGLPointAnnotation()
        station4.coordinate = CLLocationCoordinate2D(latitude: 19.12908059999998, longitude: -98.25746470000007)
        station4.title = "Nave 84 a NSO"
        station4.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station4)
        
        let station5 = MGLPointAnnotation()
        station5.coordinate = CLLocationCoordinate2D(latitude: 19.1267118, longitude: -98.25849870000002)
        station5.title = "Nave 83 a NSO"
        station5.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station5)
        
        let station6 = MGLPointAnnotation()
        station6.coordinate = CLLocationCoordinate2D(latitude: 19.125741200000007, longitude: -98.25937049999993)
        station6.title = "Est. 9 a NSO"
        station6.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station6)
        
        let station7 = MGLPointAnnotation()
        station7.coordinate = CLLocationCoordinate2D(latitude: 19.123986300000023, longitude: -98.25773570000001)
        station7.title = "Puerta 5 a NSO"
        station7.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station7)
        
        let station8 = MGLPointAnnotation()
        station8.coordinate = CLLocationCoordinate2D(latitude: 19.12253679999998, longitude: -98.25631409999994)
        station8.title = "Puerta 4 a NSO"
        station8.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station8)
        
        let station9 = MGLPointAnnotation()
        station9.coordinate = CLLocationCoordinate2D(latitude: 19.121515499999994, longitude: -98.25527069999998)
        station9.title = "Cubo 8 a NSO"
        station9.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station9)
        
        let station10 = MGLPointAnnotation()
        station10.coordinate = CLLocationCoordinate2D(latitude: 19.120778000000005, longitude: -98.25453579999999)
        station10.title = "Cubo 6 a NSO"
        station10.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station10)
        
        let station11 = MGLPointAnnotation()
        station11.coordinate = CLLocationCoordinate2D(latitude: 19.11952359999999, longitude: -98.25327779999998)
        station11.title = "Cubo 3 a NSO"
        station11.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station11)
        
        let station12 = MGLPointAnnotation()
        station12.coordinate = CLLocationCoordinate2D(latitude: 19.11850990000001, longitude: -98.25227870000003)
        station12.title = "Puerta 2 a NSO"
        station12.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station12)
        
        let station13 = MGLPointAnnotation()
        station13.coordinate = CLLocationCoordinate2D(latitude: 19.117351099999976, longitude: -98.25114280000003)
        station13.title = "Nave 53 (NSO)"
        station13.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station13)
        
        let station14 = MGLPointAnnotation()
        station14.coordinate = CLLocationCoordinate2D(latitude: 19.115924300000003, longitude: -98.24975549999999)
        station14.title = "Puerta 8 (NSO)"
        station14.subtitle = "Salidas: 07:45, 07:55, 08:05, 08:15, 08:25"
        
        // Add marker `hello` to the map.
        mapView.addAnnotation(station14)
        
        
        
        let crafter1 = MyCustomPointAnnotation()
        crafter1.coordinate = CLLocationCoordinate2D(latitude: 19.127341, longitude: -98.255458)
        crafter1.title = "Crafter 1"
        crafter1.subtitle = "Driver: Mike"
        crafter1.willUseImage = true
        
        let crafter2 = MyCustomPointAnnotation()
        crafter2.coordinate = CLLocationCoordinate2D(latitude: 19.127750, longitude: -98.253077)
        crafter2.title = "Crafter 2"
        crafter2.subtitle = "Driver: John"
        crafter2.willUseImage = true
        
        let crafter3 = MyCustomPointAnnotation()
        crafter3.coordinate = CLLocationCoordinate2D(latitude: 19.125333, longitude: -98.251719)
        crafter3.title = "Crafter 3"
        crafter3.subtitle = "Driver: Alex"
        crafter3.willUseImage = true
        
        let crafter4 = MyCustomPointAnnotation()
        crafter4.coordinate = CLLocationCoordinate2D(latitude: 19.129423, longitude: -98.252526)
        crafter4.title = "Crafter 4"
        crafter4.subtitle = "Driver: Sue"
        crafter4.willUseImage = true
        
        let myPlaces = [crafter1, crafter2, crafter3, crafter4]
        
        // Add all annotations to the map all at once, instead of individually.
        mapView.addAnnotations(myPlaces)
    }
    
    func getLocationCrafters(){
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLocations), userInfo: nil, repeats: true)
    }
    
    @objc func updateLocations(){
        
    }
    
    // Use the default marker. See also: our view annotation or custom marker examples.
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if let castAnnotation = annotation as? MyCustomPointAnnotation {
            if (castAnnotation.willUseImage) {
                return nil;
            }
        }
        
        // Assign a reuse identifier to be used by both of the annotation views, taking advantage of their similarities.
        let reuseIdentifier = "reusableDotView"
        
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = MGLAnnotationView(reuseIdentifier: reuseIdentifier)
            annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            annotationView?.layer.cornerRadius = (annotationView?.frame.size.width)! / 2
            annotationView?.layer.borderWidth = 4.0
            annotationView?.layer.borderColor = UIColor.white.cgColor
            annotationView!.backgroundColor = UIColor(red:0.03, green:0.80, blue:0.69, alpha:1.0)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        
        if let castAnnotation = annotation as? MyCustomPointAnnotation {
            if (!castAnnotation.willUseImage) {
                return nil;
            }
        }
        
        // For better performance, always try to reuse existing annotations.
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "camera")
        
        // If there is no reusable annotation image available, initialize a new one.
        if(annotationImage == nil) {
            annotationImage = MGLAnnotationImage(image: UIImage(named: "camera")!, reuseIdentifier: "camera")
        }
        
        return annotationImage
    }
    
    
    // Allow callout view to appear when an annotation is tapped.
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
