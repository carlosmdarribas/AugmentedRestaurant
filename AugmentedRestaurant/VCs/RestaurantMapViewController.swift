//
//  RestaurantMapViewController.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import UIKit
import MapKit

class RestaurantMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var coordinates: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let coordinates = self.coordinates else { return }
        self.mapView.setCenter(coordinates, animated: true)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
