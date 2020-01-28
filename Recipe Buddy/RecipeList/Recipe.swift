//
//  Recipe.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

struct Recipe: Decodable, Hashable {
    let id = UUID().uuidString
    let title: String
    let href: String
    let ingredients: String
    let thumbnail: String
}
