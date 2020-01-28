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

typealias networkCompletion = (Result<[Recipe],APIError>) -> Void

final class RecipeListAPIService {
    
    let session: URLSessionProtocol
    let baseURL = "http://www.recipepuppy.com/api/"
    
    init(session: URLSessionProtocol = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    func search(for parameters: [String], completionHandler: @escaping networkCompletion) {
        getItems(for: parameters, page: 0,  completionHandler: completionHandler)
    }
    
    func getNextPage(for parameters: [String], page: UInt, completion: @escaping networkCompletion) {
        getItems(for: parameters, page: page, completionHandler: completion)
    }
    
    private func getItems(for parameters: [String], page: UInt, completionHandler: @escaping networkCompletion) {
        let searchString = parameters.joined(separator: ",")
        let url = URL(string: "\(baseURL)?i=\(searchString)&p=\(page)")!
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
