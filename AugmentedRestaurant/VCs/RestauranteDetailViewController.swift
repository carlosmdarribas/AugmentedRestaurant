



//
//  RestauranteDetailViewController.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import UIKit
import MapKit

class RestauranteDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var featuredCV: UICollectionView!
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var recommendationsCV: UICollectionView!
    
    @IBOutlet weak var featuredView: UIView!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var recommendationsView: UIView!
    @IBOutlet weak var indicationsView: UIView!
    
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for cvView in [self.featuredView, self.categoriesView, self.recommendationsView, self.indicationsView] {
            guard let cView = cvView else { continue }
            cView.layer.cornerRadius = 10
            cView.layer.shadowColor = UIColor.black.cgColor
            cView.layer.shadowOffset = .zero
            cView.layer.shadowOpacity = 0.1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.nameLabel.text = restaurant.name
        self.mapView.setCenter(restaurant.coordinates, animated: true)
    }
    
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getEmotion(_ sender: Any) {
        guard let emotionsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "emotionVC") as? EmotionDetectorViewController else { return }
        self.show(emotionsView, sender: self)
    }
}
