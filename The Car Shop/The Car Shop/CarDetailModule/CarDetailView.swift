//
//  CarDetailView.swift
//  The Car Shop
//
//  Created by Paolo Ramos Mendez on 8/12/20.
//  Copyright © 2020 paololabs. All rights reserved.
//

import Foundation
import UIKit
import ZKCarousel
import Kingfisher
import FCAlertView

class CarDetailView: UIViewController {

    // MARK: Properties
    var presenter: CarDetailPresenterProtocol?
    var carData: CarData = CarData()
    var carousel = ZKCarousel()
    var titleArray = ["Name","Model","Price","Status","Year","Date released","Seats","Category"]
    var detailArray = [String]()
    let alert = FCAlertView()
    var valueData = String()
    var keyData = String()
    
    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCategoryButton: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigation()
        self.setupUI()
    }
    
    @IBAction func addCategory(_ sender: UIButton) {
        alert.colorScheme = .red
        alert.addTextField(withPlaceholder: "Add Category") { (data) in
            guard let value = data else { return }
            if !value.isEmpty {
                self.keyData = value
            }
        }
        
        alert.addTextField(withPlaceholder: "Add Value") { (data) in
            guard let value = data else { return }
            if !value.isEmpty {
                self.valueData = value
            }
        }
        
        alert.showAlert(inView: self,
                        withTitle: "Adding Category",
                        withSubtitle: "Here you can add a new category and value",
                        withCustomImage: nil,
                        withDoneButtonTitle: nil,
                        andButtons: nil)
    }
    
    func downloadImage(with urlString : String, slide: ZKCarouselSlide) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
                slide.slideImage = value.image
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func getDate(timestamp: String) -> String {
        if let timeResult = Double(timestamp) {
            let date = Date(timeIntervalSince1970: timeResult)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = .current
            let localDate = dateFormatter.string(from: date)
            return localDate
        }
        return String()
    }
    
    func setupNavigation() {
        guard navigationController != nil else { return }
        let image = UIImage(named: "headerlogo.png") //Your logo url here
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    func customizeData() {
        self.detailArray = [self.carData.name,self.carData.model, "$ \(self.carData.price)", self.carData.status, self.carData.year, self.getDate(timestamp: self.carData.dateReleased), self.carData.seats, self.carData.type]
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    func setupUI() {
        self.alert.delegate = self
        self.customizeData()
        self.carousel = {
            let carousel = ZKCarousel()
            for i in 0..<10 {
                if i < self.carData.media.count {
                    let url = self.carData.media[i].stringValue
                    let slide = ZKCarouselSlide(image: UIImage(named: "thecarshop-white") ?? UIImage(), title: self.carData.model, description: "$ \(self.carData.price)")
                    self.downloadImage(with: url, slide: slide)
                    carousel.slides.append(slide)
                }
                else if self.carData.media.count == 0 {
                    let slide = ZKCarouselSlide(image: UIImage(named: "thecarshop-white") ?? UIImage(), title: self.carData.model, description: self.carData.year)
                    carousel.slides.append(slide)
                }
                else {
                    break
                }
            }
            return carousel
        }()
        
        self.carousel.frame = self.carouselView.frame
        self.view.addSubview(self.carousel)
        
    }
    
}

extension CarDetailView: CarDetailViewProtocol {
    
    // TODO: implement view output methods
}

extension CarDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

extension CarDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.detailTextLabel?.text = self.detailArray[indexPath.row]
       return cell
    }
}

extension CarDetailView: FCAlertViewDelegate {
    func fcAlertDoneButtonClicked(_ alertView: FCAlertView!) {
        // Update Data
        CategoryHandler.sharedInstance.createCategory(key: self.keyData, value: self.valueData)
        _ = CategoryHandler.sharedInstance.retrieveData()
        self.carData.key = self.keyData
        self.carData.value = self.valueData
        self.titleArray.removeLast()
        self.detailArray.removeLast()
        self.titleArray.append(self.carData.key)
        self.detailArray.append(self.carData.value)
        self.tableView.reloadData()
        
    }
}
