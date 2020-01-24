//
//  RecipeListInteractor.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

enum RecipeListError: Error {
    case noResult
}

final class RecipeListInteractor {}



protocol RecipeListInteractorProtocol: AnyObject {
    func didFind(items: [Recipe]) -> Result<[Recipe], RecipeListError>
}

extension RecipeListInteractor: RecipeListInteractorProtocol {
    func didFind(items: [Recipe]) -> Result<[Recipe], RecipeListError> {
        return .success(items)
    }
}
