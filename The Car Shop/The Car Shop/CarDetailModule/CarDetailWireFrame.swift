//
//  CarDetailWireFrame.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import UIKit

class CarDetailWireFrame: CarDetailWireFrameProtocol {
    
    class func createCarDetailModule(with carData: CarData) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CarDetailView")
        if let view = viewController as? CarDetailView {
            let presenter: CarDetailPresenterProtocol & CarDetailInteractorOutputProtocol = CarDetailPresenter()
            let interactor: CarDetailInteractorInputProtocol & CarDetailRemoteDataManagerOutputProtocol = CarDetailInteractor()
            let localDataManager: CarDetailLocalDataManagerInputProtocol = CarDetailLocalDataManager()
            let remoteDataManager: CarDetailRemoteDataManagerInputProtocol = CarDetailRemoteDataManager()
            let wireFrame: CarDetailWireFrameProtocol = CarDetailWireFrame()
            
            view.presenter = presenter
            view.carData = carData
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
