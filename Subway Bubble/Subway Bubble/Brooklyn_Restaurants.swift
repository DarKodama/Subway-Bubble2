//
//  Brooklyn_Restaurants.swift
//  Subway Bubble
//
//  Created by Thaddeus Heitmann on 6/11/18.
//  Copyright © 2018 Thaddeus Heitmann. All rights reserved.
//

//Restaurant Class

import Foundation
import MapKit
import Contacts

class Restaurant: NSObject, MKAnnotation {
    let name: String?
    let cuisine: String
    let address: String
    let coordinates: CLLocationCoordinate2D
    
    init(name: String, cuisine: String, address: String, coordinates:
        CLLocationCoordinate2D) {
        self.name = name
        self.cuisine = cuisine
        self.address = address
        self.coordinates = coordinates
        
        super.init()
    }

    /*
    // Failable initializer for other artwork inputs
    init?(json: [Any]) {
        // 1
        self.name = json[0] as? String ?? "No Title"
        self.cuisine = json[5] as! String
        self.address = json[3] as! String
        // 2
        if let latitude = Double(json[6] as! String),
            let longitude = Double(json[7] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    var subtitle: String? {
        return cuisine
    }
 
 */
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        return mapItem
    }
}

extension Restaurant {
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            // let coordinates = (json["LATITUDE"], json["LONGITUDE"]) as? [String: Double],
            let latitude = json["LATITUDE"],
            let longitude = json["LONGITUDE"],
            let cuisineJSON = json["CUISINE DESCRIPTION"] as? [String]
            else {
                return nil
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
}
