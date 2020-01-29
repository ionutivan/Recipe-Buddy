//
//  RecipeDetailViewController.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 28/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit
import WebKit

class RecipeDetailViewController: UIViewController {
    
    var presenter: RecipeDetailPresenterInterface!
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.load(presenter.recipe.href)
    }
}

extension RecipeDetailViewController: RecipeDetailViewInterface {}
