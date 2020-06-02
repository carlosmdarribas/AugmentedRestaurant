//
//  MainViewController.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    // Outlets
    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var featuringCV: UICollectionView!
    @IBOutlet weak var emotionsCV: UICollectionView!
    
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var trendingView: UIView!
    @IBOutlet weak var emotionsView: UIView!
    
    private var restaurants = [Restaurant]()
    private var categories = [Category(name: "Italiana", image: #imageLiteral(resourceName: "italian")),
                              Category(name: "Rápida", image: #imageLiteral(resourceName: "fast")),
                              Category(name: "Española", image: #imageLiteral(resourceName: "spanish")),
                              Category(name: "Japonés", image: #imageLiteral(resourceName: "japan"))]
    
    private var emotions:[emotions] = [.angry, .normal, .normal, .happy]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoriesCV.register(UINib.init(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "categoriesCell")
        self.featuringCV.register(UINib.init(nibName: "FeaturedCell", bundle: nil), forCellWithReuseIdentifier: "featuredCell")
        self.emotionsCV.register(UINib.init(nibName: "EmotionsCell", bundle: nil), forCellWithReuseIdentifier: "emotionsCell")
        
        for cvView in [self.categoriesView, self.trendingView, self.emotionsView] {
            guard let cView = cvView else { continue }
            cView.layer.cornerRadius = 10
            cView.layer.shadowColor = UIColor.black.cgColor
            cView.layer.shadowOffset = .zero
            cView.layer.shadowOpacity = 0.1
        }
        
        // Restaurante 1.
        let plates1 = [Plate(name: "Hamburguesa de Kobe Premium", image: #imageLiteral(resourceName: "hamburger"), description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris in aliquet erat, rutrum placerat lectus. Suspendisse semper quam elementum enim accumsan interdum. Vivamus sit amet sapien in ante vehicula ullamcorper. Donec eleifend luctus massa, sit amet interdum urna euismod at. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut porta et urna a ultrices. Maecenas vitae hendrerit dolor, id semper erat. Nullam imperdiet tortor nulla. Nunc dignissim aliquam lorem, dictum vehicula diam pharetra eu."),
                       Plate(name: "Hamburguesa de Buey", image: #imageLiteral(resourceName: "hamburger"), description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris in aliquet erat, rutrum placerat lectus. Suspendisse semper quam elementum enim accumsan interdum. Vivamus sit amet sapien in ante vehicula ullamcorper. Donec eleifend luctus massa, sit amet interdum urna euismod at. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut porta et urna a ultrices. Maecenas vitae hendrerit dolor, id semper erat. Nullam imperdiet tortor nulla. Nunc dignissim aliquam lorem, dictum vehicula diam pharetra eu.")]
        
        self.restaurants.append(Restaurant(name: "La Flamenca de San Juan de Dios", image: #imageLiteral(resourceName: "restaurant_img"), coordinates: CLLocationCoordinate2D(latitude: 40.965006, longitude: -5.664041), plates: plates1))
        self.restaurants.append(Restaurant(name: "Con mi guitarra lo cambio yo", image: #imageLiteral(resourceName: "restaurant_img"), coordinates: CLLocationCoordinate2D(latitude: 36.534078, longitude: -6.302024), plates: plates1))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for collection in [self.emotionsCV, self.featuringCV, self.categoriesCV] {
            guard let cView = collection else { continue }
            cView.collectionViewLayout.invalidateLayout()
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.categoriesCV: return self.categories.count
        case self.featuringCV: return self.restaurants.count
        case self.emotionsCV: return self.emotions.count
            
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case self.categoriesCV:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as! CategoriesCell
                cell.layer.cornerRadius = 10
                
                cell.categoryLabel.text = self.categories[indexPath.row].name
                cell.plateImage.image = self.categories[indexPath.row].image
                return cell
            
            case self.featuringCV:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredCell", for: indexPath) as! FeaturedCell
                cell.featuredPageControl.currentPage = indexPath.row
                cell.featuredPageControl.numberOfPages = 2
                cell.layer.cornerRadius = 10
                
                cell.featuredNameLabel.text = self.restaurants[indexPath.row].name
                cell.featuredImage.image = self.restaurants[indexPath.row].image
                return cell
                
            case self.emotionsCV:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emotionsCell", for: indexPath) as! EmotionsCell
                cell.setEmotion(emotion: self.emotions[indexPath.row])

                return cell
                
            default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            case self.featuringCV:
                guard let detailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "restaurantDetail") as? RestauranteDetailViewController else { return }
                
                detailView.modalPresentationStyle = .fullScreen
                detailView.restaurant = self.restaurants[indexPath.row]
            
                self.show(detailView, sender: self)
            
        default: return
        }
    }
}

// MARK: - Collection View Flow Layout Delegate
extension MainViewController : UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            case self.categoriesCV: return CGSize(width: 80, height: collectionView.frame.height - 10)
            case self.featuringCV: return CGSize(width: collectionView.frame.width-10, height: collectionView.frame.height - 10)
            case self.emotionsCV: return CGSize(width: 60, height: collectionView.frame.height - 10)
            default: return .zero
        }
  }
  

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

