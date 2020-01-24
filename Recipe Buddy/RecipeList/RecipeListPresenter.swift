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
    
    init(wireframe: RecipeListWireframeInterface, interactor: RecipeListInteractorProtocol, UI: RecipeListViewProtocol) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.userInterface = UI
    }
}

extension RecipeListPresenter: RecipeListViewInterface {}

extension RecipeListPresenter: RecipeListPresenterInterface {

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
