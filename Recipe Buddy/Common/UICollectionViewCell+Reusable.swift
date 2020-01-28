//
//  UICollectionViewCell+Reusable.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 27/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import UIKit

protocol CollectionViewType {
    func register<T: UICollectionViewCell>(_ cellClass: T.Type)
    func registerNib<T: UICollectionViewCell>(_ cellClass: T.Type)
    func dequeue<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T
}

extension UICollectionView: CollectionViewType {
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier:  String(describing: cellClass))
    }
    
    func registerNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        
        register(UINib(nibName: String(describing: cellClass), bundle: nil), forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeue<T: AnyObject>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as! T
    }
}

// USAGE
//let cell = collectionView.dequeue(MediaCell.self, for: indexPath)!
