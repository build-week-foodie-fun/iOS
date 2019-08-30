//
//  NetworkManager.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

enum Result<String> {
	case success
	case failure(String)
}

enum NetworkResponse: String {
	case success
	case authenticationError = "You need to be authenticated first."
	case badRequest = "Bad request"
	case outdated = "The url you requested is outdated."
	case failed = "Network request failed."
	case noData = "Response returned with no data to decode."
	case unableToDecode = "Could not decode the response."
	
	static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
		switch response.statusCode {
		case 200...299: return .success
		case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
		case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
		case 600: return .failure(NetworkResponse.outdated.rawValue)
		default: return .failure(NetworkResponse.failed.rawValue)
		}
	}
}

struct NetworkManager {
	static let shared = NetworkManager()
	
	let router = Router<FoodieRouter>()
	
	func getBool(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> (Bool?, String?) {
		if error != nil {
			return (nil, error?.localizedDescription)
		}
		
		if let response = response as? HTTPURLResponse {
			let result = NetworkResponse.handleNetworkResponse(response)
			switch result {
			case .success:
				guard data != nil else {
					return (nil, NetworkResponse.noData.rawValue)
				}
				
				var result = false
				if let resultString = data.map({String(data: $0, encoding: .utf8)}), let resultString2 = resultString {
					if resultString2 == "1" {
						result = true
					}
					return (result, nil)
				}
			case .failure(let networkFailureError):
				return (nil, networkFailureError)
			}
		}
		return (nil, NetworkResponse.failed.rawValue)
	}
	
	func getObject<T: Codable>(_ data: Data?, _ response: URLResponse?, _ error: Error?,_ returnType: T.Type) -> (T?, String?) {
		if error != nil {
			return (nil, "Please check your network connection.")
		}
		
		if let response = response as? HTTPURLResponse {
			let result = NetworkResponse.handleNetworkResponse(response)
			switch result {
			case .success:
				guard let responseData = data else {
					return (nil, NetworkResponse.noData.rawValue)
				}
				
				do {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let apiResponse = try decoder.decode(returnType, from: responseData)
					return (apiResponse, nil)
				} catch {
					NSLog("\(error)")
					return (nil, NetworkResponse.unableToDecode.rawValue)
				}
			case .failure(let networkFailureError):
				return (nil, networkFailureError)
			}
		}
		return (nil, NetworkResponse.failed.rawValue)
	}
	
	func getArray<T: Codable>(_ data: Data?, _ response: URLResponse?, _ error: Error?,_ returnType: T.Type) -> ([T]?, String?) {
		if error != nil {
			return (nil, "Please check your network connection.")
		}
		
		if let response = response as? HTTPURLResponse {
			let result = NetworkResponse.handleNetworkResponse(response)
			switch result {
			case .success:
				guard let responseData = data else {
					return (nil, NetworkResponse.noData.rawValue)
				}
				
				do {
					let decoder = JSONDecoder()
					decoder.keyDecodingStrategy = .convertFromSnakeCase
					let apiResponse = try decoder.decode([T].self, from: responseData)
					return (apiResponse, nil)
				} catch {
					return (nil, NetworkResponse.unableToDecode.rawValue)
				}
			case .failure(let networkFailureError):
				return (nil, networkFailureError)
			}
		}
		return (nil, NetworkResponse.failed.rawValue)
	}
}
