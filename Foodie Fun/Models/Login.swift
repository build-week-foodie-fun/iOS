//
//  Login.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct Login: Codable {
	enum CodingKeys: String, CodingKey {
		case id, token
		case username = "message"
	}
	
	let id: Int
	let username: String
	let token: String
}
