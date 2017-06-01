//
//  PlaceFaveTableViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 29.05.17.
//
//

import UIKit
import SDWebImage
import RealmSwift

class PlaceFaveTableViewController: UITableViewController {

    var favePlaces = [PlaceInfo] ()
    let KEY = "AIzaSyAI-JOPMs5Yr-NhfbEnf_pNO9jA2bcOCkc"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background_3"))
        self.tableView.backgroundView?.contentMode = UIViewContentMode.scaleAspectFill
        
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorInset = UIEdgeInsets.zero
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 198
        
    }

    override func viewWillAppear(_ animated: Bool) {
        favePlaces = getListofDB()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favePlaces.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlaceFaveCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? PlaceFaveTableViewCell else {
                fatalError("The dequeued cell is not an instance of PlaceFaveCell")
        }
        
        let curPlace = favePlaces[indexPath.row]
        cell.labelPlaceName.text = curPlace.name
        cell.labelRating.text = curPlace.rating
        
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=" + curPlace.photoId! + "&key=" + self.KEY)
        cell.imageViewPlace.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "missingImage"))
        
        
        return cell
    }
    
    func getListofDB() -> [PlaceInfo] {
        let realm = try! Realm()
        let places = Array(realm.objects(PlaceInfo.self).filter("fave == 1"))
        return places.reversed()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier ?? 0)
        if segue.identifier == "SendPlaceIDFave" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let dest = segue.destination as? PlaceInfoTableViewController
                let value = favePlaces[indexPath.row].placeId
                //print("value : \(String(describing: value))")
                dest?.receivedPlaceId = value!
            }
        }
        
    }

}
