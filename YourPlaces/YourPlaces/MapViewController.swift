//
//  MapViewController.swift
//  YourPlaces
//
//  Created by Alex Belogurow on 27.03.17.
//
//

import UIKit

import GooglePlaces
import GoogleMaps
import GooglePlacePicker

class MapViewController: UIViewController {
    
    @IBOutlet weak var labelTest: UILabel!
    
    let APIKey = "AIzaSyBghNprhKqJGgY-cOZGWTpj059mgTtUxCY"

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTest.text = "Здесь подгружается карта с выбором мест"
        
        GMSServices.provideAPIKey(APIKey)
        GMSPlacesClient.provideAPIKey(APIKey)
        
        /*let camera = GMSCameraPosition.camera(withLatitude: 55.765905,
         longitude:37.685390, zoom:7)
         let mapView = GMSMapView.map(withFrame: CGRect.zero, camera:camera)
         
         
         let marker = GMSMarker()
         marker.position = camera.target
         marker.snippet = "Hello World"
         marker.map = mapView
         
         self.view = mapView */
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let center = CLLocationCoordinate2DMake(55.765905, 37.685390)
        let northEast = CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001)
        let southWest = CLLocationCoordinate2DMake(center.latitude - 0.001, center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        
        
        placePicker.pickPlace(callback: { (place, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            let location = CLLocationManager()
            location.requestWhenInUseAuthorization()
            location.startUpdatingLocation()
            
            if let place = place {
                print("\nPlace name - \(place.name)")
                print("Place id - \(place.placeID)")
                print("Place address - \(place.formattedAddress)")
                print("Place site - \(place.website)")
                print("Place open - \(place.openNowStatus.rawValue)")
                print("Place types - \(place.types)")
                print("Place price level - \(place.priceLevel.hashValue)")
            } else {
                print("No place selected")
            }
        })
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
