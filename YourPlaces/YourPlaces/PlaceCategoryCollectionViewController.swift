//
//  PlaceCategoryCollectionViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 10.04.17.
//
//

import UIKit

private let reuseIdentifier = "PlaceCategoryCell"

class PlaceCategoryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var categories = [String] ()
    var countryName = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background_3"))
        self.collectionView?.backgroundView?.contentMode = UIViewContentMode.scaleAspectFill
        
        self.navigationItem.title = "Category"

        categories += ["Airport", "Bank", "Bar", "Cafe", "Gallery", "Hospital", "Library", "Church", "School", "Police"]
        
        print(countryName)
        self.collectionView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat = 1
        let collectionCellSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionCellSize/3, height: collectionCellSize/2)
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryImage.image = UIImage(named: categories[indexPath.row])
        //cell.categoryImage.layer.cornerRadius = 4
        cell.categoryImage.layer.borderColor = UIColor.black.cgColor
        cell.categoryImage.layer.borderWidth = 0.5
    
        /*
        if indexPath.row % 5 == 0 {
            cell.backgroundColor = UIColor.red
        }
        
        if indexPath.row % 5 == 1 {
            cell.backgroundColor = UIColor.cyan
        }
        
        if indexPath.row % 5 == 2 {
            cell.backgroundColor = UIColor.green
        }
        
        if indexPath.row % 5 == 3 {
            cell.backgroundColor = UIColor.yellow
        }
        
        if indexPath.row % 5 == 4 {
            cell.backgroundColor = UIColor.orange
        }
        //cell.backgroundColor = UIColor.black
        // Configure the cell */
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SendCategory" {
            if let indexPath = self.collectionView?.indexPathsForSelectedItems {
                let dest = segue.destination as? ListOfPlacesTableViewController
                let value = countryName + "+" + categories[indexPath[0].row]
                dest?.query = value
            }
        }

    }
}

