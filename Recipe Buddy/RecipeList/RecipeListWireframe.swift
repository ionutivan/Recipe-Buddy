//
//  RecipeListWireframe.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

final class RecipeListWireframe: BaseWireframe {
    
    private let storyboard: UIStoryboard = UIStoryboard(name: "RecipeList", bundle: nil)
    
    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: RecipeListViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = RecipeListInteractor()
        let presenter = RecipeListPresenter(wireframe: self, interactor: interactor, view: moduleViewController)
        
        moduleViewController.presenter = presenter
    }
    
}

extension RecipeListWireframe: RecipeListWireframeInterface {
    func navigate(to option: RecipeListNavigationOption) {
         switch option {
         case .detail(let recipe):
             navigationController?.pushWireframe(RecipeDetailWireframe(recipe: recipe))
         case .favorites:
            print("go to favorites")
         }
    }
}

