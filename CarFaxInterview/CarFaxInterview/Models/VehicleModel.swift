//
// VehicleModel.swift
// CarFaxInterview
//
// Created by My Name and Ohter Name on 8/10/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

public struct VehicleModel: Codable, Equatable {
    let currentPrice: Int?
    let dealer: DealerModel?
    let images: Images?
    let make: String?
    let mileage: Int?
    let model: String?
    let year: Int?
    
    var modelName: String {
        var vehicleYear = ""
        if let year = year {
            vehicleYear = "\(year)"
        }
        let vehicleMake = make ?? ""
        let vehicleModel = model ?? ""
        return "\(vehicleYear) \(vehicleMake) \(vehicleModel)"
    }
    
    var modelInfo: String {
        var vehiclePrice = ""
        if let currentPrice = currentPrice {
            vehiclePrice = "$\(currentPrice)"
        }
        var vehicleMileage = ""
        if let mileage = mileage {
            vehicleMileage = "\(mileage)"
        }
        let vehicleLocation = "\(dealer?.city ?? ""), \(dealer?.state ?? "")"
        return "\(vehiclePrice) | \(vehicleMileage) Mi | \(vehicleLocation)"
    }
}

struct DealerModel: Codable, Equatable {
    let city: String?
    let phone: String?
    let state: String?
}

struct Images: Codable, Equatable {
    let firstPhoto: PhotoSizes?
}

struct PhotoSizes: Codable, Equatable {
    let large: String?
    let medium: String?
    let small: String?
}
