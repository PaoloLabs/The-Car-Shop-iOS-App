//
//  CarListRemoteDataManager.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CarListRemoteDataManager:CarListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: CarListRemoteDataManagerOutputProtocol?
    
    func readJSONFile() {
        if let path = Bundle.main.path(forResource: "services", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonData = try JSON(data: data)
                self.sendDataForCarList(jsonData: jsonData)
            }
            catch {
                print("Error parsing data from CarListRemoteDataManagerInputProtocol: \(error)")
            }
        }
    }
    
    func sendDataForCarList(jsonData: JSON) -> [CarData] {
        var carDataArray = [CarData]()
        let 
        jsonData["listings"].forEach { (key, value) in
            
        }
    }
    
}
