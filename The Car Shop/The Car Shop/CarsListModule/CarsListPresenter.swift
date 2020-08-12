//
//  CarsListPresenter.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/11/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation

class CarsListPresenter: ViewToPresenterCarsListProtocol {

    // MARK: Properties
    var view: PresenterToViewCarsListProtocol?
    var interactor: PresenterToInteractorCarsListProtocol?
    var router: PresenterToRouterCarsListProtocol?
}

extension CarsListPresenter: InteractorToPresenterCarsListProtocol {
    
}
