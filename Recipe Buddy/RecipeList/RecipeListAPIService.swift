//
//  RecipeListAPIService.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 27/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

enum APIError: Error {
    case networkError
    case decodingError
}

final class RecipeListAPIService {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    func getItems(for parameters: [String], page: UInt, completionHandler: @escaping (Result<[Recipe],APIError>) -> Void) {
        let url = URL(string: "http://www.recipepuppy.com/api/?i=onions,garlic&p=1")!
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    let recipes = try JSONDecoder().decode(Feed.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(recipes.results))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.decodingError))
                    }
                    
                }
                
            }
            if error != nil {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError))
                }
            }
        }.resume()
    }
}
