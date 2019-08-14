//
// PageData.swift
// CarFaxInterview
//
// Created by My Name and Ohter Name on 8/10/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

struct PageData: Codable {
    let listings: [VehicleModel]?
    let totalListingCount: Int?
}
