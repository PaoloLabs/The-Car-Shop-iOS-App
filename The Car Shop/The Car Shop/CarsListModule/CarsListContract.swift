//
//  CarsListContract.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/11/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCarsListProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCarsListProtocol {
    
    var view: PresenterToViewCarsListProtocol? { get set }
    var interactor: PresenterToInteractorCarsListProtocol? { get set }
    var router: PresenterToRouterCarsListProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCarsListProtocol {
    
    var presenter: InteractorToPresenterCarsListProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCarsListProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCarsListProtocol {
    
}
