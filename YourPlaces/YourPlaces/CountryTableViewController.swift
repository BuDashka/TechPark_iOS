//
//  CountryTableViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 10.04.17.
//
//

import UIKit

class CountryTableViewController: UITableViewController {
    
    var countries = [Country] ()

    override func viewDidLoad() {
        super.viewDidLoad()

        //self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background_2"))

        loadSampleCountries()
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
        return countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CountryCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? CountryTableViewCell else {
                fatalError("The dequeued cell is not an instance of CountryTableViewCell")
        }
        
        let country = countries[indexPath.row]
        
        cell.countryName.text = country.name
        cell.countryImage.image = country.photo
        
    
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellIdentifier = "SearchHeaderCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SearchHeaderTableViewCell else {
            fatalError("The dequeued cell is not an instance of SearchHeaderTableViewCell")
        }
        
        //cell.
        
        self.tableView.tableHeaderView = cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200.0
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func loadSampleCountries() {
        guard let countryRussia = Country(name: "RUSSIA", photo: UIImage(named: "Russia")) else {
            fatalError("Unable to instantiate country1")
        }
        
        guard let countryUK = Country(name: "THE UNITED KINDOM", photo: UIImage(named: "England")) else {
            fatalError("Unable to instantiate country2")
        }
        
        guard let countryFrance = Country(name: "FRANCE", photo: UIImage(named: "France")) else {
            fatalError("Unable to instantiate country3")
        }
        
        guard let countryUSA = Country(name: "THE USA", photo: UIImage(named: "USA")) else {
            fatalError("Unable to instantiate country4")
        }
        
        guard let countryChina = Country(name: "CHINA", photo: UIImage(named: "China")) else {
            fatalError("Unable to instantiate country5")
        }
        
        guard let countryMalaysia = Country(name: "MALAYSIA", photo: UIImage(named: "Malaysia")) else {
            fatalError("Unable to instantiate country6")
        }
        
        guard let countryGermany = Country(name: "GERMANY", photo: UIImage(named: "Germany")) else {
            fatalError("Unable to instantiate country7")
        }
        
        guard let countryTurkey = Country(name: "TURKEY", photo: UIImage(named: "Turkey")) else {
            fatalError("Unable to instantiate country8")
        }
        
        guard let countryItaly = Country(name: "ITALY", photo: UIImage(named: "Italy")) else {
            fatalError("Unable to instantiate country9")
        }
        
        guard let countrySpain = Country(name: "SPAIN", photo: UIImage(named: "Spain")) else {
            fatalError("Unable to instantiate country10")
        }

        
        countries += [countryMalaysia, countryRussia, countryUK, countryGermany, countryTurkey, countryItaly, countrySpain, countryChina, countryUSA, countryFrance]
    }

}
