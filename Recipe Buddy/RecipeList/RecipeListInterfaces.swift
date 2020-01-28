//
//  RecipeListInterfaces.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

protocol RecipeListViewInterface: AnyObject {
    func didTapFavoritesButton()
    func didTapSearchButton(with text: String)
    func didTapCell(for recipe: Recipe)
    
}

protocol RecipeListPresenterInterface {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
    func generateLayout() -> UICollectionViewLayout
    var snapshot: NSDiffableDataSourceSnapshot<RecipeListSection, Recipe>! {get}
    func search(for text: String, page: UInt)
    func recipe(for indexPath: IndexPath) -> Recipe
}

protocol RecipeListInteractorInterface: AnyObject {}

protocol RecipeListViewProtocol: AnyObject {
    func reloadData()
}

enum RecipeListNavigationOption {
    case detail(Recipe)
    case favorites
}

protocol RecipeListWireframeInterface {
    func navigate(to option: RecipeListNavigationOption)
}
