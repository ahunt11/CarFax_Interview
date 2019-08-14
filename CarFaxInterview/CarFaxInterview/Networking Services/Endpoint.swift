//
// Endpoint.swift
// CarFaxInterview
//
// Created by My Name and Ohter Name on 8/11/19.
// Copyright © 2019 Your Company Name. All rights reserved.
//

import Foundation

public protocol EndPointable {
    var request: URLRequest? { get }
}

class Endpoint: EndPointable {
    
    private let urlString: String
    
    var request: URLRequest? {
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
}
