//
//  RestaurantViews.swift
//  Subway Bubble
//
//  Created by Thaddeus Heitmann on 6/11/18.
//  Copyright © 2018 Thaddeus Heitmann. All rights reserved.
//

import Foundation
import MapKit
@available(iOS 11.0, *)

class RestaurantMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let restaurant = newValue as? Restaurant else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
    }
}
