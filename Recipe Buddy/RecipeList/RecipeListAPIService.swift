//
//  RecipeListAPIService.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 27/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

final class RecipeListAPIService {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    func getItems(for parameters: [String], page: UInt) {
        let url = URL(string: "http://www.recipepuppy.com/api/?i=onions,garlic&p=1")!
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let s = String(data: data, encoding: .utf8)!
                print(s)
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
