//
//  EmotionsCell.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import UIKit

class EmotionsCell: UICollectionViewCell {
    @IBOutlet weak var emotionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setEmotion(emotion: emotions) {
        var image: UIImage
        switch emotion {
            case .angry:  image = #imageLiteral(resourceName: "angry")
            case .normal: image = #imageLiteral(resourceName: "normal.png")
            case .happy:  image = #imageLiteral(resourceName: "happy.png")
            case .newTry:  image = #imageLiteral(resourceName: "newTry")
        }
        
        self.emotionImage.image = image
    }

}
