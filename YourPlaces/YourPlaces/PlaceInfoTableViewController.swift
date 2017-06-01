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
import FaveButton
import Foundation
import SystemConfiguration

class PlaceInfoTableViewController: UITableViewController, FaveButtonDelegate {

    var imageArray = [String] ()
    var place: PlaceInfo?

    let KEY = "AIzaSyAI-JOPMs5Yr-NhfbEnf_pNO9jA2bcOCkc"
    var receivedPlaceId = String()
    
    var placeKey = ["Address", "Phone", "Open now", "Price", "Website"]
    var placeValue = [String] ()
    
    var openDict = ["true" : "Yes", "false" : "No"]
    var priceDict = ["0" : "Free", "1" : "Inexpensive", "2" : "Moderate", "3" : "Expensive", "4" : "Very Expensive"]
    
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var labelPlaceName: UILabel!
    @IBOutlet weak var buttonFave: FaveButton!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonFave.delegate = self
        loadFave()
        loadJSON()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "background_3"))
        self.tableView.backgroundView?.contentMode = UIViewContentMode.scaleAspectFill
        
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorInset = UIEdgeInsets.zero
        
        headerView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 77
        
        
               
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
                
                let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=" + image + "&key=" + self.KEY)
                imageView.placeImage.sd_setShowActivityIndicatorView(true)
                imageView.placeImage.sd_setIndicatorStyle(.gray)
                imageView.placeImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "missingImage"))
                
 

                imageScrollView.addSubview(imageView)
                //imageView.frame.size.width = self.view.bounds.width
                imageView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
        }
        if (imageArray.count == 0) {
            if let imageView = Bundle.main.loadNibNamed("Image", owner: self, options: nil)?.first as? PlaceImageView {
                
                imageView.placeImage.image = #imageLiteral(resourceName: "missingImage")
                //imageView.placeImage.contentMode = .scaleAspectFill
                imageScrollView.addSubview(imageView)
                //imageView.frame.size.width = self.view.bounds.width
                imageView.frame.origin.x = 0
            }
        }
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        if (page > 0) {
            imagePageControl.currentPage = Int(page)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if (isInternetAvailable()) {
            return 1
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return placeKey.count
    }
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        place?.updateFave(isFave: selected)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlaceInfoKeyValueCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? PlaceInfoTableViewCell else {
                fatalError("The dequeued cell is not an instance of PlaceInfoKeyValueCell")
        }
        
        let key = placeKey[indexPath.row]
        let value = placeValue[indexPath.row]
        
        cell.labelKey.text = key
        if (key == "Open now") {
            cell.labelValue.text = openDict[value]
        } else if (key == "Price") {
            cell.labelValue.text = priceDict[value]
        } else {
            cell.labelValue.text = value
        }
        


        return cell
    }
    
    func loadJSON() {
        if (isInternetAvailable()) {
        if let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + self.receivedPlaceId + "&key=" + self.KEY + "&language=en") {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data)["result"]
                labelPlaceName.text = json["name"].stringValue
                viewRating.rating = json["rating"].doubleValue
                
                // REALM
                place = PlaceInfo(value: ["name":    json["name"].stringValue,
                                              "address": json["formatted_address"].stringValue,
                                              "photoId": json["photos"][0]["photo_reference"].stringValue,
                                              "placeId": json["place_id"].stringValue,
                                              "rating":  json["rating"].stringValue,
                                              "fave":    buttonFave.isSelected])
                place?.save()
                
                loadCells(json: json)
    
                print(placeValue)
                for item in json["photos"].arrayValue {
                    //print(item)
                    imageArray.append(item["photo_reference"].stringValue)
                }
            }
        }
        } else {
            let alert = UIAlertController(title: "Warning", message: "Check our Internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func loadFave() {
        let realm = try! Realm()
        let newPlace = Array(realm.objects(PlaceInfo.self).filter("placeId == %a", receivedPlaceId))
        if (newPlace.count == 1 && newPlace[0].fave) {
            buttonFave?.isSelected = newPlace[0].fave
        }
    }
    
    func loadCells(json : JSON) {
        placeValue.append(json["formatted_address"].stringValue)
        placeValue.append(json["formatted_phone_number"].stringValue)
        placeValue.append(json["opening_hours"]["open_now"].stringValue)
        placeValue.append(json["price_level"].stringValue)
        placeValue.append(json["website"].stringValue)
        
        for item in stride(from: placeValue.count - 1, to: 0, by: -1) {
            if placeValue[item] == "" {
                placeValue.remove(at: item)
                placeKey.remove(at: item)
            }
        }
        
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

   
}
