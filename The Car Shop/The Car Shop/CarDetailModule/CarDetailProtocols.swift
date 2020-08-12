//
//  CarDetailProtocols.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import UIKit

protocol CarDetailViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: CarDetailPresenterProtocol? { get set }
}

protocol CarDetailWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createCarDetailModule(with carData: CarData) -> UIViewController
}

protocol CarDetailPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: CarDetailViewProtocol? { get set }
    var interactor: CarDetailInteractorInputProtocol? { get set }
    var wireFrame: CarDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol CarDetailInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol CarDetailInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: CarDetailInteractorOutputProtocol? { get set }
    var localDatamanager: CarDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CarDetailRemoteDataManagerInputProtocol? { get set }
}

protocol CarDetailDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol CarDetailRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CarDetailRemoteDataManagerOutputProtocol? { get set }
}

protocol CarDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol CarDetailLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
