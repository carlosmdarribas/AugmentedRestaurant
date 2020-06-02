



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
        
        self.mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToMap)))
        
        self.featuredCV.register(UINib.init(nibName: "FeaturedCell", bundle: nil), forCellWithReuseIdentifier: "featuredCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.nameLabel.text = restaurant.name
        self.mapView.setCenter(restaurant.coordinates, animated: true)
    }
    
    @objc func goToMap() {
        
        guard let mapVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "restaurantMapVC") as? RestaurantMapViewController else { return }
        
        mapVC.coordinates = self.restaurant.coordinates
        self.show(mapVC, sender: self)
    }
    
    @IBAction func exit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getEmotion(_ sender: Any) {
        guard let emotionsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "emotionVC") as? EmotionDetectorViewController else { return }
        self.show(emotionsView, sender: self)
    }
}


extension RestauranteDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.featuredCV: return self.restaurant.plates.count
            
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case self.featuredCV:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredCell", for: indexPath) as! FeaturedCell
                cell.featuredPageControl.currentPage = indexPath.row
                cell.featuredPageControl.numberOfPages = 2
                cell.layer.cornerRadius = 10
                
                cell.featuredNameLabel.text = self.restaurant.plates[indexPath.row].plateName
                cell.featuredImage.image = self.restaurant.plates[indexPath.row].plateImage
                return cell
                
            default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            case self.featuredCV:
                guard let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "restaurantPlateVC") as? RestaurantPlateViewController else { return }
                
                detailView.modalPresentationStyle = .fullScreen
            
                self.show(detailView, sender: self)
            
        default: return
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension RestauranteDetailViewController : UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case self.featuredCV: return CGSize(width: collectionView.frame.width-10, height: collectionView.frame.height - 10)
            default: return .zero
        }
  }
  

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

