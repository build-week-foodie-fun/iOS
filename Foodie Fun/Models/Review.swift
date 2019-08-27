//
//  Review.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

struct Review: Codable {
	let id: Int
	let restaurantName: String
	let restaurantType: String
	let createdAt: Date
	let userId: Int
	let itemName: String
	let photoOfOrder: URL
	let foodRating: Int
	let comments: String
	let price: Double
	let waitTime: String
	let dateOfVisit: String
}
