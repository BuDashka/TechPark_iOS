//
//  Place.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 21.05.17.
//
//

import UIKit

class Place {
    var name: String?
    var rating: Float?
    var placeID: String?
    
    
    init?(placeID: String, name: String, rating: Float) {
        self.placeID = placeID
        self.name = name
        self.rating = rating
    }
}
