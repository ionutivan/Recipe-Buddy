//
//  RecipeListInterfaces.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

protocol RecipeListPresenterInterface {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
    func search(for text: String)
    func getNextPage(for text: String, page: UInt)
    func receivedTap(for indexPath: IndexPath)
    func recipeCount() -> Int
    var currentPage: UInt {get}
  func didTapFavorites()
}

protocol RecipeListInteractorInterface: AnyObject {}

protocol RecipeListViewProtocol: AnyObject {
    func reloadData()
    func present(alertText: String)
    func show(recipes: [Recipe])
}

enum RecipeListNavigationOption {
    case detail(Recipe)
    case favorites
}

extension RecipeListNavigationOption: Equatable {
  static func == (lhs: Self, rhs: Self) -> Bool {
    switch (lhs, rhs) {
    case (favorites, favorites):
      return true
    case (detail(let recipe1), detail(let recipe2)):
      if recipe1.id == recipe2.id {
        return true
      } else {
        return false
      }
    default:
      return false
  }
  }
}

protocol RecipeListWireframeInterface {
    func navigate(to option: RecipeListNavigationOption)
}
