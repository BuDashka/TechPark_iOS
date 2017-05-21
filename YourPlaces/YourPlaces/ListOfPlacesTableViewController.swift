//
//  ListOfPlacesTableViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 21.05.17.
//
//

import UIKit

class ListOfPlacesTableViewController: UITableViewController {
    
    var query = String()
    var categories = [String] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categories += ["Airport", "Bank", "Bar", "Cafe", "Gallery", "Hospital", "Library", "Church", "School", "Police"]
        
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
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlaceSearchInfoCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? ListOfPlacesTableViewCell else {
                fatalError("The dequeued cell is not an instance of ListOfPlacesTableViewCell")
        }
        
        let country = categories[indexPath.row]
        cell.labelPlaceName.text = country
        
    
        return cell
    }
}
