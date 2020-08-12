//
//  CarListPresenter.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation

class CarListPresenter  {
    
    // MARK: Properties
    weak var view: CarListViewProtocol?
    var interactor: CarListInteractorInputProtocol?
    var wireFrame: CarListWireFrameProtocol?
    
}

extension CarListPresenter: CarListPresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.getDataFromRemoteDataManager()
    }
    
    func goCarDetailView(carData: CarData) {
        wireFrame?.goCarDetailView(with: view, carData: carData)
    }
    
}

extension CarListPresenter: CarListInteractorOutputProtocol {
    // TODO: implement interactor utput methods
    func getDataFromRemoteDataManager(with carDataArray: [CarData]) {
        view?.getDataFromRemoteDataManager(with: carDataArray)
    }
}
