//
//  RecipeDetailInterfaces.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 28/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

protocol RecipeDetailInteractorProtocol: AnyObject {}

protocol RecipeDetailPresenterInterface {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
    var recipe: Recipe {get}
}

enum RecipeDetailNavigationOption {
    case None
}

protocol RecipeDetailWireframeProtocol {
    func navigate(to option: RecipeDetailNavigationOption)
}

protocol RecipeDetailViewInterface: AnyObject {}

