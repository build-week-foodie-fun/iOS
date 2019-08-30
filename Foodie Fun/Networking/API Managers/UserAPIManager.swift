//
//  UserAPIManager.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation


extension NetworkManager {
	
	func register(newUser: LoginRequest, completion: @escaping (_ login: ReturnID?, _ error: String?) -> Void) {
		router.request(.register(request: newUser)) { (data, response, error) in
			let returnRequest = self.getObject(data, response, error, ReturnID.self)
			completion(returnRequest.0, returnRequest.1)
		}
	}
	
	func login(credentials: LoginRequest, completion: @escaping (_ login: Login?, _ error: String?) -> Void) {
		router.request(.login(request: credentials)) { (data, response, error) in
			let returnRequest = self.getObject(data, response, error, Login.self)
			completion(returnRequest.0, returnRequest.1)
		}
	}
}
