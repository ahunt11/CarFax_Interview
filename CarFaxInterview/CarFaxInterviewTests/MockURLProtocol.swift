//
// MockURLProtocol.swift
// CarFaxInterviewTests
//
// Created by My Name and Ohter Name on 8/11/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation
class MockURLProtocol: URLProtocol {
    
    static var testURLs = [URL?: Data]()
    static var forceError = false
    static var shouldFail = false
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let url = request.url {
            if let data = MockURLProtocol.testURLs[url] {
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocol(self, didLoad: data)
            }
        }
        // Very important line to include.  If it's not here, then the loading will never work
        if MockURLProtocol.shouldFail {
                        self.client?.urlProtocol(self, didFailWithError: TestError.generalError)
        } else {
            self.client?.urlProtocolDidFinishLoading(self)
        }

    }
    
    override func stopLoading() {
        
    }
    
}

fileprivate enum TestError: Error {
    case generalError
}
