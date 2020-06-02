




//
//  RestaurantPlateViewController.swift
//  AugmentedRestaurant
//
//  Created by Carlos on 02/06/2020.
//  Copyright © 2020 carlosdmarribas. All rights reserved.
//

import UIKit

class RestaurantPlateViewController: UIViewController {
    var plate: Plate!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let plate = self.plate, let nameLabel = self.nameLabel, let descriptionLabel = self.descriptionLabel else { return }
        nameLabel.text = plate.plateName
        descriptionLabel.text = plate.description
    }
    
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
