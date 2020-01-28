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
    
    weak var delegate: RecipeListViewInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: presenter.generateLayout())
        cv.backgroundColor = .systemGray4
        collectionView = cv
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        configureCollectionView()
        configureDataSource()
        presenter.viewDidLoad()
        datasource.apply(presenter.snapshot, animatingDifferences: true)
        
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
            
            return cell
        })
        
    }
    
    
}

extension RecipeListViewController: RecipeListViewProtocol {
    func reloadData() {
        datasource.apply(presenter.snapshot, animatingDifferences: true)
    }
}

extension RecipeListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = presenter.recipe(for: indexPath)
        
        delegate?.didTapCell(for: recipe)
    }
}
