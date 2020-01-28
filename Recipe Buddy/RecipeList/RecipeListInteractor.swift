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
    
}

protocol RecipeListInteractorProtocol: AnyObject {
    func searchItems(for text: String, page: UInt)
}

extension RecipeListInteractor: RecipeListInteractorProtocol {
    func searchItems(for text: String, page: UInt = 0) {
        // call the API service
        RecipeListAPIService().getItems(for: [], page: 0, completionHandler: { [weak self] result in
            self?.delegate?.didFinishGettingItems(with: result)
            })
    }
}

protocol RecipeListInteractorDelegate: AnyObject {
    func didFinishGettingItems(with result: Result<[Recipe], APIError>)
}
