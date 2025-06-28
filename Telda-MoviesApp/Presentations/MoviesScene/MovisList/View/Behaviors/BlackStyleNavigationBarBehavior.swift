//
//  BlackStyleNavigationBarBehavior.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 28/06/2025.
//

import UIKit

struct BlackStyleNavigationBarBehavior: ViewControllerLifecycleBehavior {

    func viewDidLoad(viewController: UIViewController) {

        viewController.navigationController?.navigationBar.barStyle = .black
    }
}
