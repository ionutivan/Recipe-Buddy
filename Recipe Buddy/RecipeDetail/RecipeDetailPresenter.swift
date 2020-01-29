//
//  RecipeDetailPresenter.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 28/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

final class RecipeDetailPresenter {
    
    private weak var userInterface: RecipeDetailViewInterface?
    private let wireframe: RecipeDetailWireframeProtocol
    private let interactor: RecipeDetailInteractorProtocol
    let recipe: Recipe
    
    init(wireframe: RecipeDetailWireframeProtocol, UI: RecipeDetailViewInterface, interactor: RecipeDetailInteractorProtocol, recipe: Recipe) {
        self.wireframe = wireframe
        self.recipe = recipe
        self.userInterface = UI
        self.interactor = interactor
    }

}

extension RecipeDetailPresenter: RecipeDetailPresenterInterface {

    func viewDidLoad() {
        fatalError("Implementation pending...")
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
