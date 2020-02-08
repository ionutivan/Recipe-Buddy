//
//  RecipeListPresenter.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

enum RecipeListSection: CaseIterable {
    case main
}


final class RecipeListPresenter {
    
    private unowned var userInterface: RecipeListViewProtocol
    private let interactor: RecipeListInteractorProtocol
    private let wireframe: RecipeListWireframeInterface
    
    var snapshot: NSDiffableDataSourceSnapshot<RecipeListSection, Recipe>!
    
    
    init(wireframe: RecipeListWireframeInterface, interactor: RecipeListInteractorProtocol, view: RecipeListViewProtocol) {
        self.wireframe = wireframe
        self.interactor = interactor
        self.userInterface = view
        
        (interactor as? RecipeListInteractor)?.delegate = self
    }
    
    private var collectionLayoutSection: NSCollectionLayoutSection {
                
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(220)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),  heightDimension: .estimated(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        (userInterface as! RecipeListViewController).delegate = self
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
}

extension RecipeListPresenter: RecipeListViewInterface {
    func didTapSearchButton(with text: String) {
        interactor.searchItems(for: text)
    }
    
    func didTapFavoritesButton() {
        wireframe.navigate(to: .favorites)
    }
    
}

extension RecipeListPresenter: RecipeListPresenterInterface {

    func viewDidLoad() {
        snapshot = NSDiffableDataSourceSnapshot()
        snapshot.appendSections([.main])
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
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: collectionLayoutSection)
        return layout
    }
    
    func search(for text: String) {
        interactor.searchItems(for: text)
    }
    
    func getNextPage(for text: String, page: UInt) {
        interactor.getNextPageItems(for: text, page: page)
    }
    
    func recipeCount() -> Int {
        return interactor.recipes.count
    }
    
    var currentPage: UInt {
        return interactor.currentPage
    }
    
    func present(error: Error) -> UIAlertController {
        let alertController = UIAlertController(title: "An error occurred", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        return alertController
    }
    
    func receivedTap(for indexPath: IndexPath) {
        let recipe = interactor.recipe(for: indexPath)
        wireframe.navigate(to: .detail(recipe))
    }
}

extension RecipeListPresenter: RecipeListInteractorDelegate {
    func didFinishGettingItems() {
        DispatchQueue.main.async { [weak self] in
            if let interactor = self?.interactor {
                self?.snapshot.appendItems(interactor.recipes, toSection: .main)
                self?.userInterface.reloadData()
            }
        }
    }
    
    func didErrorWhileGettingItems(error: Error) {
        DispatchQueue.main.async { [weak self] in
            if let alertController = self?.present(error: error) {
                self?.userInterface.present(alert: alertController)
            }
        }
        
        
    }
}
