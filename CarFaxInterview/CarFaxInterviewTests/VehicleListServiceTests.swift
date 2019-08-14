//
// VehicleListServiceTests.swift
// CarFaxInterviewTests
//
// Created by My Name and Ohter Name on 8/8/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking

@testable import CarFaxInterview

class VehicleListServiceTests: XCTestCase {
    
    lazy var testURL = "www.test.com"
    lazy var testEndpoint = Endpoint(urlString: testURL)
    private let bag = DisposeBag()
    
    let mockURLSession: URLSession = {
        let mockURLSessionConfiguration = URLSessionConfiguration.default
        mockURLSessionConfiguration.protocolClasses = [MockURLProtocol.self]
       let closureSession = URLSession(configuration: mockURLSessionConfiguration)
        return closureSession
    }()
    lazy var subject = VehicleListService(session: mockURLSession, endpoint: testEndpoint)
    
    let testData: Data = {
        let url = Bundle.main.url(forResource: "PageData_Incomplete", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }()
    
    lazy var dealerModel1 = DealerModel(city: "Buena Park", phone: "8332202334", state: "CA")
    lazy var dealerModel2 = DealerModel(city: "Montclair", phone: "8663014042", state: "CA")
    lazy var dealerModel3 = DealerModel(city: "Santa Ana", phone: "6572952046", state: "CA")
    
    lazy var photosizes1 = PhotoSizes(large: "https://carfax-img.vast.com/carfax/-9050308143659109979/1/640x480", medium: "https://carfax-img.vast.com/carfax/-9050308143659109979/1/344x258", small: "https://carfax-img.vast.com/carfax/-9050308143659109979/1/120x90")
    lazy var photosizes2 = PhotoSizes(large: "https://carfax-img.vast.com/carfax/-6601530003191280406/1/640x480", medium: "https://carfax-img.vast.com/carfax/-6601530003191280406/1/344x258", small: "https://carfax-img.vast.com/carfax/-6601530003191280406/1/120x90")
    lazy var photosizes3 = PhotoSizes(large:  "https://carfax-img.vast.com/carfax/9087421416548588762/1/640x480", medium: "https://carfax-img.vast.com/carfax/9087421416548588762/1/344x258", small: "https://carfax-img.vast.com/carfax/9087421416548588762/1/120x90")
    
    lazy var images1 = Images(firstPhoto: photosizes1)
    lazy var images2 = Images(firstPhoto: photosizes2)
    lazy var images3 = Images(firstPhoto: photosizes3)

    lazy var vehicleModel1 = VehicleModel(currentPrice: 11994, dealer: dealerModel1, images: images1, make: "Acura", mileage: 82303, model: "ILX", year: 2014)
    lazy var vehicleModel2 = VehicleModel(currentPrice: 15599, dealer: dealerModel2, images: images2, make: "Acura", mileage: 40192, model: "ILX", year: 2016)
    lazy var vehicleModel3 = VehicleModel(currentPrice: 12991, dealer: dealerModel3, images: images3, make: "Acura", mileage: 71697, model: "ILX", year: 2015)

    func test_successfulFetchListOfVehicles() {
        URLProtocol.registerClass(MockURLProtocol.self)
        MockURLProtocol.testURLs = [URL(string: testURL): testData]
        let expectedVehicleModels = [
            vehicleModel1,
            vehicleModel2,
            vehicleModel3
        ]
        var actualVehicleModels: [VehicleModel]!
        let fetchExpectation = expectation(description: "fetchListOfVehiclesExpectation")
        
        subject.fetchListOfVehicles()
            .subscribe(onNext: {
                actualVehicleModels = $0
                fetchExpectation.fulfill()
            })
            .disposed(by: bag)
        
        
        wait(for: [fetchExpectation], timeout: 1.0)
        guard let observedVehicleModels = actualVehicleModels else {
            XCTFail("Fail due to no observed vehicle models")
            return
        }
        XCTAssertEqual(observedVehicleModels, expectedVehicleModels)
    }
    
    func test_failFetchListOfVehicles() {
        // TODO: - Finish this test
    }

    func test_successfulFetchVehicleImage() {
        // TODO: - Finish this test
    }
    
    func test_failFetchVehicleImage() {
        // TODO: - Finish this test
    }
}
