//
//  PlaceInfo.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 27.05.17.
//
//

import UIKit
import RealmSwift

class PlaceInfo: Object {
    
    dynamic var name: String?
    dynamic var address: String?
    dynamic var photoId: String?
    dynamic var placeId: String?
    dynamic var rating: String?
    dynamic var fave = false
    
    func save() {
        let realm = try! Realm()
        try! realm.write {
                realm.add(self)
        }
    }


}
