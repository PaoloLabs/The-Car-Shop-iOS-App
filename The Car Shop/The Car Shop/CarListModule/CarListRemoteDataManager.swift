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
                let carDataArray = self.sendDataForCarList(jsonData: jsonData)
                remoteRequestHandler?.getDataFromRemoteDataManager(with: carDataArray)
                
            }
            catch {
                print("Error parsing data from CarListRemoteDataManagerInputProtocol: \(error)")
            }
        }
    }
    
    func sendDataForCarList(jsonData: JSON) -> [CarData] {
        var carDataArray = [CarData]()
        let jsonArray = jsonData["listings"].arrayValue
        jsonArray.forEach { (item) in
            let carData = CarData(model: item["build"]["model"].stringValue,
                                  price: item["price"].stringValue,
                                  seats: item["build"]["std_seating"].stringValue,
                                  status: item["inventory_type"].stringValue,
                                  year: item["build"]["year"].stringValue,
                                  dateReleased: item["first_seen_at"].stringValue,
                                  type: item["build"]["vehicle_type"].stringValue,
                                  name: item["dealer"]["name"].stringValue,
                                  media: item["media"]["photo_links"].arrayValue)
            carDataArray.append(carData)
        }
        return carDataArray
    }
}
