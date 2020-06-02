
//
//  FeaturedCell.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell {
    @IBOutlet weak var featuredImage: UIImageView!
    @IBOutlet weak var featuredNameLabel: UILabel!
    @IBOutlet weak var featuredPageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
