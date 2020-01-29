//
//  RecipeFavoritesService.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 29/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

class RecipeFavoritesService {
    
    let key = "favoriteRecipes"
    
    func getFavorites() -> [Recipe] {
        let defaults = UserDefaults.standard
        if let savedFavorites = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            do {
                let loadedFavorites = try decoder.decode([Recipe].self, from: savedFavorites)
                return loadedFavorites
            } catch {
                print(error)
            }
            
        }
        return []
    }
    
    func saveToFavorites(recipes: [Recipe]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipes) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    func isInFavorites(recipe: Recipe) -> Bool {
        let defaults = UserDefaults.standard
        if let savedFavorites = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            do {
                let loadedFavorites = try decoder.decode([Recipe].self, from: savedFavorites)
                return loadedFavorites.contains(recipe)
            } catch {
                return false
            }
            
        }
        return false
    }
    
}
