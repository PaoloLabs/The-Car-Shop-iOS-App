//
//  CarListWireFrame.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import UIKit

class CarListWireFrame: CarListWireFrameProtocol {
    
    class func createCarListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "CarListNav")
        if let view = navController.children.first as? CarListView {
            let presenter: CarListPresenterProtocol & CarListInteractorOutputProtocol = CarListPresenter()
            let interactor: CarListInteractorInputProtocol & CarListRemoteDataManagerOutputProtocol = CarListInteractor()
            let localDataManager: CarListLocalDataManagerInputProtocol = CarListLocalDataManager()
            let remoteDataManager: CarListRemoteDataManagerInputProtocol = CarListRemoteDataManager()
            let wireFrame: CarListWireFrameProtocol = CarListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func goCarDetailView(with view: CarListViewProtocol?, carData: CarData) {
        if let vc = view as? UIViewController {
            print(carData.name)
//            let carDetailView = CarDetailWireFrame.createCarDetailModule(with: carData)
//            vc.navigationController?.pushViewController(carDetailView, animated: true)
        }
        
    }
}
