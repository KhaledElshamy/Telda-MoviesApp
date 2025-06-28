//
//  ReusableView.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 28/06/2025.
//

import UIKit

protocol ReusableView {
    static var defaultReuseIdentifier : String { get }
}

extension ReusableView where Self: UITableViewCell {
    static var defaultReuseIdentifier : String {
        return String(describing: self)
    }
}

extension ReusableView where Self: UICollectionViewCell {
    static var defaultReuseIdentifier : String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UICollectionViewCell: ReusableView {}
