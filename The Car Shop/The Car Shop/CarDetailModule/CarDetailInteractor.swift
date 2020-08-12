//
//  CarDetailInteractor.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation

class CarDetailInteractor: CarDetailInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: CarDetailInteractorOutputProtocol?
    var localDatamanager: CarDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: CarDetailRemoteDataManagerInputProtocol?

}

extension CarDetailInteractor: CarDetailRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
