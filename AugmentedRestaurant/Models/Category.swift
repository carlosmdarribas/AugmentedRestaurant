//
//  Category.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import Foundation
import UIKit

class Category {
    var name: String = ""
    var image: UIImage!
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
