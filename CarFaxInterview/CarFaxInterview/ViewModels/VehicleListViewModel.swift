//
// VehicleListViewModel.swift
// CarFaxInterview
//
// Created by My Name and Ohter Name on 8/13/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

import RxSwift
import UIKit

protocol VehicleListViewable {
    func fetchListOfVehicles() -> Observable<[VehicleModel]>
    func fetchVehicleImage(urlString: String) -> Observable<UIImage?>
    func fetchVehicleModelsWithImages(vehicleModels: [VehicleModel]) -> Observable<[VehicleModelWithImage]>
}

class VehicleListViewModel: VehicleListViewable {
    
    let vehicleService: VehicleListServiceable
    
    init(vehicleService: VehicleListServiceable) {
        self.vehicleService = vehicleService
    }
    
    convenience init() {
        let endpoint = Endpoint(urlString: "https://carfax-for-consumers.firebaseio.com/assignment.json")
        let vehicleService = VehicleListService(endpoint: endpoint)
        self.init(vehicleService: vehicleService)
    }
    
    func fetchListOfVehicles() -> Observable<[VehicleModel]> {
        return vehicleService.fetchListOfVehicles()
    }
    
    func fetchVehicleImage(urlString: String) -> Observable<UIImage?> {
        return vehicleService.fetchVehicleImage(urlString: urlString)
    }
    
    func fetchVehicleModelsWithImages(vehicleModels: [VehicleModel]) -> Observable<[VehicleModelWithImage]> {
        let imageObservables = vehicleModels.map{ (vehicleModel: VehicleModel) -> Observable<VehicleModelWithImage> in
            if let imageURLString = vehicleModel.images?.firstPhoto?.medium {
                return fetchVehicleImage(urlString: imageURLString).map{ VehicleModelWithImage(vehicleModel: vehicleModel, image: $0)}
            } else {
                return Observable<VehicleModelWithImage>.just(VehicleModelWithImage(vehicleModel: vehicleModel, image: nil))
            }
        }
        return Observable.from(imageObservables).concat().toArray().asObservable()
    }
}
