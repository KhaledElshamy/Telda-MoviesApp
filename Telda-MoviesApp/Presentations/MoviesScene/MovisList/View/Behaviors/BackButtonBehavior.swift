//
//  BackButtonBehaviour.swift
//  Telda-MoviesApp
//
//  Created by Khaled Elshamy on 28/06/2025.
//

import UIKit

struct BackButtonEmptyTitleNavigationBarBehavior: ViewControllerLifecycleBehavior {

    func viewDidLoad(viewController: UIViewController) {

        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}
