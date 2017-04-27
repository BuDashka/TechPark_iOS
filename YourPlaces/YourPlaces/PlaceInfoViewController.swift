//
//  PlaceInfoViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 27.04.17.
//
//

import UIKit

class PlaceInfoViewController: UIViewController {
    
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelRate: UILabel!
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
        let url1 = "https://maps.googleapis.com/maps/api/place/details/json?placeid=" + placeId + "&key=AIzaSyAI-JOPMs5Yr-NhfbEnf_pNO9jA2bcOCkc&language=ru"
    
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
                        }
                    }
                }
            })
            task.resume()
        }
    }
}
