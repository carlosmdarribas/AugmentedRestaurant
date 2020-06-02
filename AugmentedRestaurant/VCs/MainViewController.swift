//
//  MainViewController.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //private let sectionInsets = UIEdgeInsets(top: 00.0, left: 0.0, bottom: 0.0, right: 0.0)

    @IBOutlet weak var categoriesCV: UICollectionView!
    @IBOutlet weak var featuringCV: UICollectionView!
    @IBOutlet weak var emotionsCV: UICollectionView!
    
    
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var trendingView: UIView!
    @IBOutlet weak var emotionsView: UIView!
    
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
        case self.categoriesCV: return 4
        case self.featuringCV: return 2
        case self.emotionsCV: return 1
            
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case self.categoriesCV:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoriesCell", for: indexPath) as! CategoriesCell
                cell.backgroundColor = .systemPink
                return cell
            
            case self.featuringCV:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredCell", for: indexPath) as! FeaturedCell
                cell.featuredPageControl.currentPage = indexPath.row
                cell.featuredPageControl.numberOfPages = 2
                cell.backgroundColor = .systemPink
                return cell
                
            case self.emotionsCV:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emotionsCell", for: indexPath) as! EmotionsCell
                cell.setEmotion(emotion: .angry)
                //cell.emotionImage.image =  #imageLiteral(resourceName: "header_detail_2")
                return cell
                
            default: return UICollectionViewCell()
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

