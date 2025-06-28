//
//  Extensions.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 27/06/2025.
//

import UIKit

extension UITableView {
    
    func register<Cell: UITableViewCell>(_: Cell.Type) {
        let identifier = String(describing: Cell.self)
        let bundle = Bundle(for: Cell.self)
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: Cell.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.defaultReuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.defaultReuseIdentifier)")
        }
        return cell
    }
}
