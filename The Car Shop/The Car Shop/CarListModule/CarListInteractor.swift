//
//  CarListInteractor.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation

class CarListInteractor: CarListInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: CarListInteractorOutputProtocol?
    var localDatamanager: CarListLocalDataManagerInputProtocol?
    var remoteDatamanager: CarListRemoteDataManagerInputProtocol?

    func getDataFromRemoteDataManager() {
        print("2")
        remoteDatamanager?.readJSONFile()
        
    }
}

extension CarListInteractor: CarListRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
