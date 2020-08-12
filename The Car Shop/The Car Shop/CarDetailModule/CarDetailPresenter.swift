//
//  CarDetailPresenter.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation

class CarDetailPresenter  {
    
    // MARK: Properties
    weak var view: CarDetailViewProtocol?
    var interactor: CarDetailInteractorInputProtocol?
    var wireFrame: CarDetailWireFrameProtocol?
    
}

extension CarDetailPresenter: CarDetailPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension CarDetailPresenter: CarDetailInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
