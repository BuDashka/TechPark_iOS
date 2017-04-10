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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        categories += ["Airport", "Bank", "Bar", "Cafe", "Gallery", "Hospital", "Library", "Church", "School", "Police"]
        
        self.collectionView?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
        // Configure the cell
    
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

