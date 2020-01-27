//
//  RecipeListPresenter.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

final class RecipeListPresenter {
    
    private unowned var userInterface: RecipeListViewProtocol
    private let interactor: RecipeListInteractorProtocol
    private let wireframe: RecipeListWireframeInterface
    
    init(wireframe: RecipeListWireframeInterface, interactor: RecipeListInteractorProtocol, view: RecipeListViewProtocol) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.userInterface = view
    }
}

extension RecipeListPresenter: RecipeListViewInterface {
    func didTapSearchButton(with text: String) {
        //do search with param
        interactor.searchItems(for: text, page: 0)
    }
    
    func didTapFavoritesButton() {
        wireframe.navigate(to: .favorites)
    }
    
    func didTapCell(for recipe: Recipe) {
        wireframe.navigate(to: .detail(recipe))
    }
}

extension RecipeListPresenter: RecipeListPresenterInterface {

    func viewDidLoad() {
        interactor.searchItems(for: "text", page: 0)
    }

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
}
