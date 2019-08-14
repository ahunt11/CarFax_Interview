//
// VehicleListService.swift
// CarFaxInterview
//
// Created by My Name and Ohter Name on 8/10/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit.UIImage

protocol VehicleListServiceable {
    func fetchListOfVehicles() -> Observable<[VehicleModel]>
    func fetchVehicleImage(urlString: String) -> Observable<UIImage?>
}

class VehicleListService: VehicleListServiceable {
    func fetchVehicleImage(urlString: String) -> Observable<UIImage?> {
        guard let requestURL = URL(string: urlString) else {
            return .just(nil)
        }
        let request = URLRequest(url: requestURL)
        return session.rx.data(request: request)
            .compactMap{ UIImage(data: $0) }
            .share()
            .catchErrorJustReturn(nil)
    }
    
    private let session: URLSession
    private let endpoint: EndPointable
    
    init(session: URLSession, endpoint: EndPointable) {
        self.session = session
        self.endpoint = endpoint
    }
    
    convenience init(endpoint: EndPointable) {
        self.init(session: URLSession.shared, endpoint: endpoint)
    }
    
    func fetchListOfVehicles() -> Observable<[VehicleModel]> {
        guard let vehicleRequest = endpoint.request else { return .empty() }
        return session.rx.data(request: vehicleRequest)
            .compactMap{
                let pageData = try JSONDecoder().decode(PageData.self, from: $0)
                return pageData.listings
        }.share()
    }
}
