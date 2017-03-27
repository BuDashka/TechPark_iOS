//
//  MapViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 27.03.17.
//
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var labletTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labletTest.text = "Hello";
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
