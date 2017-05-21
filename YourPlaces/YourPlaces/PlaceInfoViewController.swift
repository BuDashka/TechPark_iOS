//
//  PlaceInfoViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 27.04.17.
//
//

import UIKit
import SDWebImage

class PlaceInfoViewController: UIViewController {
    
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var labelNumber: UILabel!
    
    @IBOutlet weak var labelSite: UILabel!
    var placeId = ""
    let KEY = "AIzaSyAI-JOPMs5Yr-NhfbEnf_pNO9jA2bcOCkc"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJSON() {
        let url1 = "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + placeId + "&key=" + KEY + "&language=ru"
    
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
