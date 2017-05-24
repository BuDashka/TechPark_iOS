//
//  PlaceInfoViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 27.04.17.
//
//

import UIKit
import SDWebImage

class PlaceInfoViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    
    @IBOutlet weak var imagesScrollView: UIScrollView!
    
    @IBOutlet weak var imagePageControl: UIPageControl!
    let imageArray = ["history", "map", "search", "background_2"]
    /*
    let feature1 = ["title":"Apple Watch","price":"$0.99","image":"background"]
    let feature2 = ["title":"More Designs","price":"$1.99","image":"background_2"]
    let feature3 = ["title":"Notifications","price":"$0.99","image":"background_3"]
     */
    
    
    
    @IBOutlet weak var labelSite: UILabel!
    var placeId = String()
    let KEY = "AIzaSyAI-JOPMs5Yr-NhfbEnf_pNO9jA2bcOCkc"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesScrollView.isPagingEnabled = true
        imagesScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(imageArray.count), height: 255)
        imagesScrollView.showsHorizontalScrollIndicator = false
        imagesScrollView.delegate = self
        
        loadImages()
        
        print(placeId)
        loadJSON()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImages() {
        for (index, item) in imageArray.enumerated() {
            if let imageView = Bundle.main.loadNibNamed("Images", owner: self, options: nil)?.first
                as? ImageView {

                imageView.placeImage.image = UIImage(named: item)
                imagesScrollView.addSubview(imageView)
                imagesScrollView.frame.size.width = self.view.bounds.size.width
                imagesScrollView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
            }
            
        }
        /*
            for (index, feature) in featureArray.enumerated() {
                if let featureView = Bundle.main.loadNibNamed("Feature", owner: self, options: nil)?.first as? FeatureView {
                    featureView.featureImageView.image = UIImage(named: feature["image"]!)
                    featureView.titleLabel.text = feature["title"]
                    featureView.priceLabel.text = feature["price"]
                    
                    featureView.purchaseButton.tag = index
                    featureView.purchaseButton.addTarget(self, action: #selector(ViewController.buyFeature(sender:)), for: .touchUpInside)
                    
                    featureScrollView.addSubview(featureView)
                    featureView.frame.size.width = self.view.bounds.size.width
                    featureView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                    
                }
                
            }
 */
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        imagePageControl.currentPage = Int(page)
    }
    
    func loadJSON() {
        let url1 = "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + placeId + "&key=" + KEY + "&language=en"
    
        let url = URL(string: url1)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
                        if let result = json["result"] as AnyObject? {
                            if let name = result["name"] as AnyObject? {
                                self.labelName.text = name as? String
                            }
                            
                            if let rate = result["rating"] as AnyObject? {
                                self.labelRate.text = String(describing: rate)
                            }
                            
                            if let photos = result["photos"] as AnyObject? {
                                if let photo = photos[0] as AnyObject? {
                                    if let ref = photo["photo_reference"] as AnyObject? {
                                        let url2 = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=3000&photoreference=" + (ref as! String) + "&key=" + self.KEY)
                                        self.imagePlace.sd_setImage(with: url2)
                                        //self.imagePlace.contentMode = UIViewContentMode.scaleAspectFill
                                    }
                                }
                            }
                            
                            if let address = result["vicinity"] as AnyObject? {
                                self.labelAddress.text = address as? String
                            }
                            
                            if let number = result["formatted_phone_number"] as AnyObject? {
                                self.labelNumber.text = number as? String
                            }
                            
                            if let site = result["website"] as AnyObject? {
                                self.labelSite.text = site as? String
                            }
                        }
                    }
                }
            })
            task.resume()
        }
    }
}
