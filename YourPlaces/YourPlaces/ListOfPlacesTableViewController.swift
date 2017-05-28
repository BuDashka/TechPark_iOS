//
//  ListOfPlacesTableViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 21.05.17.
//
//

import UIKit
import SwiftyJSON
import SDWebImage
import RealmSwift

class ListOfPlacesTableViewController: UITableViewController {
    
    let KEY = "AIzaSyAI-JOPMs5Yr-NhfbEnf_pNO9jA2bcOCkc"
    
    var query = String()
    var places = [Place] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Pick a Place"
        
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background_3"))
        self.tableView.backgroundView?.contentMode = UIViewContentMode.scaleAspectFill
        
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorInset = UIEdgeInsets.zero
        
        loadJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlaceSearchInfoCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? ListOfPlacesTableViewCell else {
                fatalError("The dequeued cell is not an instance of ListOfPlacesTableViewCell")
        }
        
        let curPlace = places[indexPath.row]
        cell.labelPlaceName.text = curPlace.name
        cell.labelRating.text = curPlace.rating
        /*
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1000&photoreference=" + curPlace.photo! + "&key=" + self.KEY)
        cell.imageViewPlacePhoto.sd_setShowActivityIndicatorView(true)
        cell.imageViewPlacePhoto.sd_setIndicatorStyle(.white)
        cell.imageViewPlacePhoto.sd_setImage(with: url)
        */
        return cell
    }
    
    func loadJSON() {
        if let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=" + query + "&key=" + KEY + "&language=en") {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data)
                for item in json["results"].arrayValue {
                    let place = Place(placeID: item["place_id"].stringValue,
                                      name: item["name"].stringValue,
                                      photo: item["photos"][0]["photo_reference"].stringValue,
                                      rating: item["rating"].stringValue)
                    //print("\(String(describing: place?.name)) - name")
                    self.places.append(place!)
                }

            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SendPlaceID" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let dest = segue.destination as? PlaceInfoTableViewController
                let value = places[indexPath.row].placeID
                //print("value : \(String(describing: value))")
                dest?.placeId = value!
            }
        }

    }
}
