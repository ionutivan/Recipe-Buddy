//
//  Feed.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 28/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

struct Feed: Decodable {
    
    let results: [Recipe]
}
