//
//  PlaceInfoTableViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 25.05.17.
//
//

import UIKit
import SwiftyJSON
import SDWebImage
import Cosmos
import RealmSwift

class PlaceInfoTableViewController: UITableViewController {

    var imageArray = [String] ()
    let KEY = "AIzaSyAI-JOPMs5Yr-NhfbEnf_pNO9jA2bcOCkc"
    var placeId = String()
    var placeKey = ["Address", "Phone", "Open_now", "Price", "Rating", "Website"]
    var placeValue = [String] ()
    
    @IBOutlet weak var imagePageControl: UIPageControl!
    
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var labelPlaceName: UILabel!
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJSON()
        
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background_3"))
        self.tableView.backgroundView?.contentMode = UIViewContentMode.scaleAspectFill
        
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorInset = UIEdgeInsets.zero
        
        headerView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        
        viewRating.settings.updateOnTouch = false
        viewRating.settings.fillMode = .precise

        imageScrollView.isPagingEnabled = true
        imageScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(imageArray.count), height: 200)
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.delegate = self
        
        imagePageControl.numberOfPages = imageArray.count
        
        loadImages()
    }
    
    func loadImages() {
        for (index, image) in imageArray.enumerated() {
            if let imageView = Bundle.main.loadNibNamed("Image", owner: self, options: nil)?.first as? PlaceImageView {
                /*
                let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=" + image + "&key=" + self.KEY)
                imageView.placeImage.sd_setShowActivityIndicatorView(true)
                imageView.placeImage.sd_setIndicatorStyle(.gray)
                imageView.placeImage.sd_setImage(with: url)
                */
 

                imageScrollView.addSubview(imageView)
                imageView.frame.size.width = self.view.bounds.width
                imageView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        imagePageControl.currentPage = Int(page)
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
        return placeKey.count
    }
    
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlaceInfoKeyValueCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? PlaceInfoTableViewCell else {
                fatalError("The dequeued cell is not an instance of PlaceInfoKeyValueCell")
        }
        
        let key = placeKey[indexPath.row]
        let value = placeValue[indexPath.row]
        
        cell.labelValue.text = value
        cell.labelKey.text = key


        return cell
    }
    
    func loadJSON() {
        if let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + self.placeId + "&key=" + self.KEY + "&language=en") {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data)["result"]
                //print(json)
                let error = "Unknown"
                print(json)
                print(json["rating"])
                placeValue.append(json["formatted_address"].string ?? error)
                placeValue.append(json["formatted_phone_number"].string ?? error)
                placeValue.append(json["opening_hours"]["open_now"].stringValue)
                placeValue.append(json["price_level"].stringValue)
                placeValue.append(json["rating"].stringValue)
                placeValue.append(json["website"].string ?? error)
                
                labelPlaceName.text = json["name"].stringValue
                viewRating.rating = json["rating"].doubleValue
                
                // REALM
                let place = PlaceInfo(value: ["name":    json["name"].stringValue,
                                              "address": json["formatted_address"].stringValue,
                                              "photoId": json["photos"][0]["photo_reference"].stringValue,
                                              "placeId": json["place_id"].stringValue,
                                              "rating":  json["rating"].stringValue])
                place.save()
    
                
                print(placeValue)
                for item in json["photos"].arrayValue {
                    //print(item)
                    imageArray.append(item["photo_reference"].stringValue)
                }
            }
        }
    }
   
}
