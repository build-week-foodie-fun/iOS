//
//  Router.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

class Router<EndPoint: EndPointType> {
	private var task: URLSessionTask?
	
	func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
		let session = URLSession.shared
		do {
			let request = try self.buildRequest(from: route)
			task = session.dataTask(with: request, completionHandler: { (data, response, error) in
				completion(data, response, error)
			})
		} catch {
			completion(nil, nil, error)
		}
		
		self.task?.resume()
	}
	
	func cancel() {
		task?.cancel()
	}
	
	private func buildRequest(from route: EndPointType) throws -> URLRequest {
		var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
		
		request.httpMethod = route.httpMethod.rawValue
		do {
			switch route.task {
			case .request:
				request.setValue("aplication/json", forHTTPHeaderField: "Content-Type")
				request.setValue(SettingsController.shared.userToken, forHTTPHeaderField: "Authorization")
			case .requestParameters(let bodyParameters):
				try configureParameters(bodyParameters: bodyParameters, request: &request)
			}
			return request
		} catch {
			throw error
		}
	}
	
	private func configureParameters(bodyParameters: Data?, request: inout URLRequest) throws {
		do {
			if let bodyParameters = bodyParameters {
				try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
			}
		} catch {
			throw error
		}
	}
}
