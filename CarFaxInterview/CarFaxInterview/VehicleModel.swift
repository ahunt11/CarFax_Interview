//
// VehicleModel.swift
// CarFaxInterview
//
// Created by My Name and Ohter Name on 8/10/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

struct VehicleModel: Codable {
    let currentPrice: Int?
    let dealer: DealerModel?
    let make: String?
    let mileage: Int?
    let model: String?
    let year: Int?
}

struct DealerModel: Codable {
    let city: String?
    let phone: String?
    let state: String?
}
