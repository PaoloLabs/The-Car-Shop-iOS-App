//
//  CarListProtocols.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import UIKit

protocol CarListViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: CarListPresenterProtocol? { get set }
}

protocol CarListWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createCarListModule() -> UIViewController
    func goCarDetailView(with view: CarListViewProtocol?)
}

protocol CarListPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: CarListViewProtocol? { get set }
    var interactor: CarListInteractorInputProtocol? { get set }
    var wireFrame: CarListWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func goCarDetailView()

}

protocol CarListInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol CarListInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: CarListInteractorOutputProtocol? { get set }
    var localDatamanager: CarListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: CarListRemoteDataManagerInputProtocol? { get set }
}

protocol CarListDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol CarListRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: CarListRemoteDataManagerOutputProtocol? { get set }
}

protocol CarListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol CarListLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
