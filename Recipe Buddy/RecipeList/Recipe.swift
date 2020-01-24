//
//  Recipe.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

class Recipe: Decodable {
    var title: String
    var href: String
    var ingredients: String
    var thumbnail: String
}
