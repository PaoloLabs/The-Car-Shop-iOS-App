//
//  CarsListViewController.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/11/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import UIKit

class CarsListViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterCarsListProtocol?
    
}

extension CarsListViewController: PresenterToViewCarsListProtocol{
    // TODO: Implement View Output Methods
}
