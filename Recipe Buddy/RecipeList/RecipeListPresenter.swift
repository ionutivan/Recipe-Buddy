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
    
    func didTapCell(for recipe: Recipe) {
        wireframe.navigate(to: .detail(recipe))
    }
    
}

extension RecipeListPresenter: RecipeListPresenterInterface {

    func viewDidLoad() {
        snapshot = NSDiffableDataSourceSnapshot()
        snapshot.appendSections([.main])
        interactor.searchItems(for: "onion,garlic")
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
    
    func search(for text: String, page: UInt) {
        interactor.getNextPageItems(for: text, page: page)
    }
    
    func recipe(for indexPath: IndexPath) -> Recipe {
        print(interactor.recipes.count)
        print(indexPath.row)
        print(indexPath)
        precondition(interactor.recipes.count>indexPath.row, "Should not be index out of bounds")
        return interactor.recipes[indexPath.row]
    }
}

extension RecipeListPresenter: RecipeListInteractorDelegate {
    func didFinishGettingItems() {
        snapshot.appendItems(interactor.recipes, toSection: .main)
        userInterface.reloadData()
    }
    
    func didErrorWhileGettingItems() {
        print("got an error")
    }
}
