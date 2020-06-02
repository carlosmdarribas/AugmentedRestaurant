//
//  Restaurant.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class Restaurant {
    var name: String
    var image: UIImage
    var coordinates: CLLocationCoordinate2D
    
    var plates = [Plates]()
    
    init(name: String, image: UIImage, coordinates: CLLocationCoordinate2D, plates: [Plates]? = nil) {
        self.name = name
        self.image = image
        self.coordinates = coordinates
        
        guard let plates = plates else { return }
        for plate in plates { self.plates.append(plate) }
    }
}

class Plates {
    var plateName: String
    var plateImage: UIImage
    var description: String
    
    init(name: String, image: UIImage, description: String) {
        self.plateName = name
        self.plateImage = image
        self.description = description
    }
}
