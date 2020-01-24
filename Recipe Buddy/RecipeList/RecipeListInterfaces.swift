//
//  RecipeListInterfaces.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import Foundation

protocol RecipeListViewInterface: AnyObject {}

protocol RecipeListPresenterInterface {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}

protocol RecipeListInteractorInterface: AnyObject {}

protocol RecipeListViewProtocol: AnyObject {}

enum RecipeListNavigationOption {
    case detail
    case favorites
}

protocol RecipeListWireframeInterface {
    func navigate(to option: RecipeListNavigationOption)
}
