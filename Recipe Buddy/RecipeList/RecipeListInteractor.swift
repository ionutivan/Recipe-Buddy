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
    let favsService: RecipeFavoritesService
    var recipes: [Recipe] = []
    var currentPage: UInt = 1
    
    init(apiService: RecipeListAPIService = RecipeListAPIService(), favsService: RecipeFavoritesService = RecipeFavoritesService()) {
        self.apiService = apiService
        self.favsService = favsService
    }
    
}

protocol RecipeListInteractorProtocol: AnyObject {
    func searchItems(for text: String)
    func getNextPageItems(for text: String, page: UInt)
    var recipes: [Recipe] {get}
    var currentPage: UInt {get}
    
    func addToFavorites(recipe: Recipe)
    func getFavorites() -> [Recipe]
}

extension RecipeListInteractor: RecipeListInteractorProtocol {
    func searchItems(for text: String) {
        // call the API service
        
        apiService.search(for: text, completionHandler: { [weak self] result in
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
        apiService.getNextPage(for: text, page: page, completion: { [weak self] result in
            switch result {
            case .success(let newRecipes):
                self?.recipes += newRecipes
                self?.delegate?.didFinishGettingItems()
            case .failure(let error):
                print(error)
                self?.delegate?.didErrorWhileGettingItems(error: error)
            }
        })
    }
    
    func addToFavorites(recipe: Recipe) {
        var favorites = favsService.getFavorites()
        if favsService.isInFavorites(recipe: recipe) {
            return
        }
        favorites.append(recipe)
        favsService.saveToFavorites(recipes: favorites)
    }
    
    func getFavorites() -> [Recipe] {
        return favsService.getFavorites()
    }
    
    func removeFromFavorites(recipe: Recipe) {
        let favorites = favsService.getFavorites()
        let filtered = favorites.filter {$0.id != recipe.id}
        favsService.saveToFavorites(recipes: filtered)
    }
}

protocol RecipeListInteractorDelegate: AnyObject {
    func didFinishGettingItems()
    func didErrorWhileGettingItems(error: Error)
}
