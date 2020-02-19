//
//  RecipeListViewController.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 24/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit
import Kingfisher

final class RecipeListViewController: UIViewController {
    
    var presenter: RecipeListPresenterInterface!
    var collectionView: UICollectionView! = nil
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var snapshot: NSDiffableDataSourceSnapshot<RecipeListSection, Recipe>!
    private var collectionLayoutSection: NSCollectionLayoutSection {
                
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(220)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),  heightDimension: .estimated(220))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        cv.backgroundColor = .systemGray4
        collectionView = cv
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        configureCollectionView()
        configureDataSource()
        snapshot = NSDiffableDataSourceSnapshot()
        snapshot.appendSections([.main])
        presenter.viewDidLoad()
        datasource.apply(snapshot, animatingDifferences: true)
    }
    
    func configureCollectionView() {
        collectionView.registerNib(RecipeCell.self)
    }
    
    private var datasource: UICollectionViewDiffableDataSource<RecipeListSection, Recipe>!
    
    private func configureDataSource() {
        
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, recipe) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeue(RecipeCell.self, for: indexPath)
            cell.ingredients.text = recipe.ingredients.trimmingCharacters(in: .whitespacesAndNewlines)
            cell.name.text = recipe.title.trimmingCharacters(in: .whitespacesAndNewlines)
            if let url = URL(string: recipe.thumbnail) {
                cell.mainImage.kf.setImage(with: url)
            }
            cell.hasLactose.isHidden = !recipe.hasLactose
            return cell
        })
        
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: collectionLayoutSection)
        return layout
    }
  
  func didTapFavorites() {
    presenter.didTapFavorites()
  }
    
    
}

extension RecipeListViewController: RecipeListViewProtocol {
    func show(recipes: [Recipe]) {
        snapshot.appendItems(recipes, toSection: .main)
    }
    
    func reloadData() {
        datasource.apply(snapshot, animatingDifferences: true)
    }
    
    func present(alertText: String) {
        let alertController = UIAlertController(title: "An error occurred", message: alertText, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    
}

extension RecipeListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.receivedTap(for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.recipeCount() - 3 {
            guard let searchText = searchBar.searchTextField.text else {
                return
            }
            presenter.getNextPage(for: searchText, page: presenter.currentPage+1)
        }
    }
}

extension RecipeListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text else {
            searchBar.endEditing(true)
            return
        }
        presenter.search(for: searchText)
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.endEditing(true)
    }
}



