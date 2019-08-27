//
//  Service.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
	case delete = "DELETE"
	case get = "GET"
	case patch	= "PATCH"
	case post = "POST"
	case put = "PUT"
}

protocol EndPointType {
	var baseURL: URL { get }
	var path: String { get }
	var httpMethod: HTTPMethod { get }
	var task: HTTPTask { get }
}

enum HTTPTask {
	case request
	case requestParameters(bodyParameters: Data?)
}

enum NetworkError: Error {
	case badURL
	case noToken
	case noData
	case notDecoding
	case notEncoding
	case other(Error)
}
