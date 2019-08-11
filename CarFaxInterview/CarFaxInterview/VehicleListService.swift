//
// VehicleListService.swift
// CarFaxInterview
//
// Created by My Name and Ohter Name on 8/10/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation
import RxSwift

class VehicleListService {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    convenience init() {
        self.init(session: URLSession.shared)
    }
    
    func fetchListOfVehicles() -> Observable<[VehicleModel]?> {
        return .empty()
    }
}
