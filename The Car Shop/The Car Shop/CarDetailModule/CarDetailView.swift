//
//  CarDetailView.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import UIKit

class CarDetailView: UIViewController {

    // MARK: Properties
    var presenter: CarDetailPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CarDetailView: CarDetailViewProtocol {
    // TODO: implement view output methods
}
