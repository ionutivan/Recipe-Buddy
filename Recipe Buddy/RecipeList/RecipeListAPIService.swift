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
    let d: [String: Any] = [
      "title": "Recipe Puppy",
      "version": 0.1,
      "href": "http://www.recipepuppy.com/",
      "results": [
        [
          "title": "Garlic Dijon Grilling Sauce \r\n\t\t\r\n\t\r\n\t\t\r\n\t\r\n\t\t\r\n\t\r\n\t\r\n\r\n",
          "href": "http://www.kraftfoods.com/kf/recipes/garlic-dijon-grilling-sauce-56449.aspx",
          "ingredients": "garlic, dijon mustard",
          "thumbnail": "http://img.recipepuppy.com/631164.jpg"
        ],
        [
          "title": "Bruschetta With Roasted Garlic and Cherry Tomatoes",
          "href": "http://www.recipezaar.com/Bruschetta-With-Roasted-Garlic-and-Cherry-Tomatoes-244281",
          "ingredients": "garlic, italian bread",
          "thumbnail": "http://img.recipepuppy.com/199304.jpg"
        ],
        [
          "title": "Flatbread With Za?atar",
          "href": "http://www.recipezaar.com/Flatbread-With-Zaatar-178010",
          "ingredients": "garlic, pita bread",
          "thumbnail": "http://img.recipepuppy.com/567386.jpg"
        ],
        [
          "title": "Garlic Butter for Steaks and Mash Potatoes",
          "href": "http://www.recipezaar.com/garlic-butter-for-steaks-and-mash-potatoes-358993",
          "ingredients": "butter, garlic",
          "thumbnail": "http://img.recipepuppy.com/642047.jpg"
        ],
        [
          "title": "Garlic Vinegar",
          "href": "http://www.recipezaar.com/Garlic-Vinegar-251602",
          "ingredients": "garlic, garlic, vinegar",
          "thumbnail": "http://img.recipepuppy.com/647882.jpg"
        ],
        [
          "title": "Garlic Croutons",
          "href": "http://allrecipes.com/Recipe/Garlic-Croutons/Detail.aspx",
          "ingredients": "butter, garlic",
          "thumbnail": "http://img.recipepuppy.com/19040.jpg"
        ],
        [
          "title": "Kittencal's Do-Ahead Garlic",
          "href": "http://www.recipezaar.com/Kittencals-Do-Ahead-Garlic-73596",
          "ingredients": "garlic, vegetable oil",
          "thumbnail": "http://img.recipepuppy.com/40503.jpg"
        ],
        [
          "title": "Roasted Garlic",
          "href": "http://allrecipes.com/Recipe/Roasted-Garlic/Detail.aspx",
          "ingredients": "garlic, olive oil",
          "thumbnail": "http://img.recipepuppy.com/30536.jpg"
        ],
        [
          "title": "White Bean Spread With Garlic & Rosemary",
          "href": "http://allrecipes.com/Recipe/White-Bean-Spread-With-Garlic--Rosemary/Detail.aspx",
          "ingredients": "garlic, olive oil",
          "thumbnail": "http://img.recipepuppy.com/2268.jpg"
        ],
        [
          "title": "Romano Cheese Crisp",
          "href": "http://allrecipes.com/Recipe/Romano-Cheese-Crisp/Detail.aspx",
          "ingredients": "garlic, romano cheese",
          "thumbnail": "http://img.recipepuppy.com/9493.jpg"
        ]
      ]
    ]
    
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
        print(url)
        let s: Data? = Data(d.utf8)
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let recipes = try JSONDecoder().decode(Feed.self, from: data)
//                    DispatchQueue.main.async {
                        completionHandler(.success(recipes.results))
//                    }
                } catch {
//                    DispatchQueue.main.async {
                        print(error)
                        completionHandler(.failure(.decodingError(error)))
//                    }
                    
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
