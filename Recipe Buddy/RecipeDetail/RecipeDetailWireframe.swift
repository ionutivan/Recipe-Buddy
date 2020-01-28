//
//  RecipeDetailWireframe.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 28/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

class RecipeDetailWireframe: BaseWireframe {
    
    private let storyboard: UIStoryboard = UIStoryboard(name: "RecipeDetail", bundle: nil)
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        let moduleViewController = storyboard.instantiateViewController(ofType: RecipeDetailViewController.self)
        super.init(viewController: moduleViewController)
        let interactor = RecipeDetailInteractor()
        
        let presenter = RecipeDetailPresenter(wireframe: self, UI: moduleViewController, interactor: interactor,  recipe: recipe)
        moduleViewController.presenter = presenter
        
    }
}

extension RecipeDetailWireframe: RecipeDetailWireframeProtocol {
    func navigate(to option: RecipeDetailNavigationOption) {
         
    }
}
