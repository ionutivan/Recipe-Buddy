//
//  RecipeCell.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 27/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var hasLactose: UILabel!
    
    @IBAction func makeFavorite(_: UIButton) {
        
    }
    
    override func draw(_ rect: CGRect) {
        hasLactose.transform = CGAffineTransform(rotationAngle: .pi / 4)
    }
}
