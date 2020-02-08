//
//  RecipeListPresenter.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

enum RecipeListSection: CaseIterable {
    case main
}


final class RecipeListPresenter {
    
    private unowned var userInterface: RecipeListViewProtocol
    private let interactor: RecipeListInteractorProtocol
    private let wireframe: RecipeListWireframeInterface
    
    init(wireframe: RecipeListWireframeInterface, interactor: RecipeListInteractorProtocol, view: RecipeListViewProtocol) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.userInterface = view
        
        (interactor as? RecipeListInteractor)?.delegate = self
    }
    
}

extension RecipeListPresenter: RecipeListPresenterInterface {

    func viewDidLoad() {}

    func viewWillAppear(animated: Bool) {
        fatalError("Implementation pending...")
    }

    func viewDidAppear(animated: Bool) {
        fatalError("Implementation pending...")
    }

    func viewWillDisappear(animated: Bool) {
        fatalError("Implementation pending...")
    }

    func viewDidDisappear(animated: Bool) {
        fatalError("Implementation pending...")
    }
    
    func search(for text: String) {
        interactor.searchItems(for: text)
    }
    
    func getNextPage(for text: String, page: UInt) {
        interactor.getNextPageItems(for: text, page: page)
    }
    
    func recipeCount() -> Int {
        return interactor.recipes.count
    }
    
    var currentPage: UInt {
        return interactor.currentPage
    }
    
    func present(error: Error) {
        userInterface.present(alertText: error.localizedDescription)
    }
    
    func receivedTap(for indexPath: IndexPath) {
        let recipe = interactor.recipe(for: indexPath)
        wireframe.navigate(to: .detail(recipe))
    }
}

extension RecipeListPresenter: RecipeListInteractorDelegate {
    func didFinishGettingItems() {
        DispatchQueue.main.async { [weak self] in
            if let interactor = self?.interactor {
                self?.userInterface.show(recipes: interactor.recipes)
                self?.userInterface.reloadData()
            }
        }
    }
    
    func didErrorWhileGettingItems(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.present(error: error)
        }
    }
}
