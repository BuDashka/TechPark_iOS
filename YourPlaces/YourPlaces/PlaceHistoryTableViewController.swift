//
//  PlaceHistoryTableViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 28.05.17.
//
//

import UIKit
import RealmSwift

class PlaceHistoryTableViewController: UITableViewController {

    var places = [PlaceInfo] ()
    let KEY = "AIzaSyAI-JOPMs5Yr-NhfbEnf_pNO9jA2bcOCkc"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background_3"))
        self.tableView.backgroundView?.contentMode = UIViewContentMode.scaleAspectFill
        
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        places = getListofDB()
        self.tableView.reloadData()
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
        let cellIdentifier = "PlaceHistoryCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? PlaceHistoryTableViewCell else {
                fatalError("The dequeued cell is not an instance of PlaceHistoryCell")
        }
        
        let curPlace = places[indexPath.row]
        cell.labelPlaceName.text = curPlace.name
        cell.labelRating.text = curPlace.rating
        

        let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=" + curPlace.photoId! + "&key=" + self.KEY)
        cell.imageViewPlace.sd_setShowActivityIndicatorView(true)
        cell.imageViewPlace.sd_setIndicatorStyle(.white)
        cell.imageViewPlace.sd_setImage(with: url)
 
        return cell
    }
 
    func getListofDB() -> [PlaceInfo] {
        let realm = try! Realm()
        places = Array(realm.objects(PlaceInfo.self))
        print(places)
        return places.reversed()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SendPlaceIDHistory" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let dest = segue.destination as? PlaceInfoTableViewController
                let value = places[indexPath.row].placeId
                //print("value : \(String(describing: value))")
                dest?.receivedPlaceId = value!
            }
        }
        
    }

}
