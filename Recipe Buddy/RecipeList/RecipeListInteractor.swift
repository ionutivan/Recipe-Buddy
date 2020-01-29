//
//  RecipeListInteractor.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

enum RecipeListError {
    case noResult
}

final class RecipeListInteractor: NSObject {
    weak var delegate: RecipeListInteractorDelegate?
    let apiService: RecipeListAPIService
    var recipes: [Recipe] = []
    var currentPage: UInt = 1
    
    init(apiService: RecipeListAPIService = RecipeListAPIService()) {
        self.apiService = apiService
    }
    
}

protocol RecipeListInteractorProtocol: AnyObject {
    func searchItems(for text: String)
    func getNextPageItems(for text: String, page: UInt)
    var recipes: [Recipe] {get}
    var currentPage: UInt {get}
}

extension RecipeListInteractor: RecipeListInteractorProtocol {
    func searchItems(for text: String) {
        // call the API service
        
        apiService.search(for: "onion,garlic", completionHandler: { [weak self] result in
            switch result {
            case .success(let recipes):
                self?.recipes = recipes
                self?.delegate?.didFinishGettingItems()
            case .failure(let error):
                print(error)
                self?.delegate?.didErrorWhileGettingItems(error: error)
            }
            
            })
    }
    
    func getNextPageItems(for text: String, page: UInt=1) {
        currentPage = page
        apiService.getNextPage(for: "onion,garlic", page: page, completion: { [weak self] result in
            switch result {
            case .success(let newRecipes):
                self?.recipes += newRecipes
                //there may be need to stick newRecipes into the didFinish method
                self?.delegate?.didFinishGettingItems()
            case .failure(let error):
                print(error)
                self?.delegate?.didErrorWhileGettingItems(error: error)
            }
        })
    }
}

protocol RecipeListInteractorDelegate: AnyObject {
    func didFinishGettingItems()
    func didErrorWhileGettingItems(error: Error)
}
