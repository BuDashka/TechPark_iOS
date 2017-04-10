//
//  Country.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 10.04.17.
//
//

import UIKit

class Country {
    
    var name: String
    var photo: UIImage?
    //var rating: Int
    
    init?(name: String, photo: UIImage?) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        self.name = name
        self.photo = photo
    }
}
