//
//  RecipeListAPIService.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 27/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

enum APIError: Error {
    case networkError(Error)
    case decodingError(Error)
}

typealias networkCompletion = (Result<[Recipe],APIError>) -> Void

final class RecipeListAPIService {
    
    let session: URLSessionProtocol
    let baseURL = "http://www.recipepuppy.com/api/"
    
    init(session: URLSessionProtocol = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    func search(for text: String, completionHandler: @escaping networkCompletion) {
        getItems(for: text, page: 1,  completionHandler: completionHandler)
    }
    
    func getNextPage(for text: String, page: UInt, completion: @escaping networkCompletion) {
        getItems(for: text, page: page, completionHandler: completion)
    }
    
    private func getItems(for text: String, page: UInt, completionHandler: @escaping networkCompletion) {
        let url = URL(string: "\(baseURL)?i=\(text)&p=\(page)")!
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
                        print(error)
                        completionHandler(.failure(.decodingError(error)))
                    }
                    
                }
                
            }
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.networkError(error)))
                }
            }
        }.resume()
    }
}
