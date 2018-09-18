//
//  ViewController.swift
//  Subway Bubble
//
//  Created by Thaddeus Heitmann on 9/1/17.
//  Copyright © 2017 Thaddeus Heitmann. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial location in Brooklyn
        let initialLocation = CLLocation(latitude: 40.6880369, longitude: -73.92001959999999)
        let regionRadius: CLLocationDistance = 1500
        func centerMapOnLocation(location: CLLocation){
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        
        //Call RestaurantViews class
        mapView.register(RestaurantMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        // Show restaurants from JSON on map
        loadInitialData()
        mapView.addAnnotations(restaurants)
    }
    
    // Array to hold Restaurant objects from JSON file
    var restaurants: [Restaurant] = []

    // Load JSON data into Restaurant array
    func loadInitialData() {
        // 1
        guard let fileName = Bundle.main.path(forResource: "BrooklynData", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        guard
            let data = optionalData,
            // 2
            let json = try? JSONSerialization.jsonObject(with: data),
            // 3
            let dictionary = json as? [String: Any],
            // 4
            let works = dictionary["data"] as? [[Any]]
            else { return }
        // 5
        let validWorks = works.flatMap { Restaurant(json: $0) }
        restaurants.append(contentsOf: validWorks)
    }
}

init?(json: [String: Any]) {
    guard let name = json["name"] as? String,
        // let coordinates = (json["LATITUDE"], json["LONGITUDE"]) as? [String: Double],
        let latitude = json["LATITUDE"] as? [Double],
        let longitude = json["LONGITUDE"] as? [Double],
        let cuisineJSON = json["CUISINE DESCRIPTION"] as? [String],
        let coordinates = (latitude, longitude) as? ([Double],[Double])
        else {
            return nil
        }
    }
    /*
     var meals: Set<Meal> = []
     for string in mealsJSON {
     guard let meal = Meal(rawValue: string) else {
     return nil
     }
     
     meals.insert(meal)
     }
     */
    
    self.name = name
    self.coordinates = (latitude, longitude)
    self.cuisine = cuisineJSON
    // self.meals = meals
}


extension ViewController: MKMapViewDelegate {
    //info button
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Restaurant
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}

