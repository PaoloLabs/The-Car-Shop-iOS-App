//
//  CarsListRouter.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/11/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import UIKit

class CarsListRouter: PresenterToRouterCarsListProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = CarsListViewController()
        
        let presenter: ViewToPresenterCarsListProtocol & InteractorToPresenterCarsListProtocol = CarsListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = CarsListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = CarsListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
