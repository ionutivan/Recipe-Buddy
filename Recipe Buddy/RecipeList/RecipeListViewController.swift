//
//  RecipeListViewController.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

final class RecipeListViewController: UIViewController {
    
    var presenter: RecipeListPresenterInterface!
    
}

extension RecipeListViewController: RecipeListViewProtocol {}
