//
//  FoodieRouter.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

enum FoodieRouter {
	case register(request: LoginRequest)
	case login(request: LoginRequest)
	case putReview(reviewId: Int?, request: ReviewRequest)
	case getReviews
	case deleteReviewBy(id: Int)
}

extension FoodieRouter: EndPointType {
	var baseURL: URL {
		guard let url = URL(string: "https://buildweek-foodie1.herokuapp.com/") else { fatalError("baseURL could not be configured")}
		return url
	}
	
	var path: String {
		switch self {
		case .register(_):
			return "register"
		case .login(_):
			return "login"
		case .putReview(let id, _):
			if let reviewId = id {
				return "auth/api/\(reviewId)"
			} else {
				return "auth/api"
			}
		case .getReviews:
			return "auth/api"
		case .deleteReviewBy(let reviewId):
			return "auth/api/\(reviewId)"
		}
	}
	
	var httpMethod: HTTPMethod {
		switch self {
		case .register(_),
			 .login(_):
			return .post
		case .putReview(let id, _):
			if id != nil {
				return .put
			} else {
				return .post
			}
		case .getReviews:
			return .get
		case .deleteReviewBy:
			return .delete
		}
	}
	
	var task: HTTPTask {
		switch self {
		case .register(let data):
			let json = try? data.encode()
			return .requestParameters(bodyParameters: json)
		case .login(let data):
			let json = try? data.encode()
			return .requestParameters(bodyParameters: json)
		case .putReview(_, let data):
			let json = try? data.encode()
			return .requestParameters(bodyParameters: json)
		default:
			return.request
		}
	}	
}
