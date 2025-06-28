//
//  NibLoadable.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 28/06/2025.
//

import UIKit

protocol NibLoadable {
    static var nibName : String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName : String {
        return String(describing: self)
    }
}
