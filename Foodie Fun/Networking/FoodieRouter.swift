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
	case postReview(request: ReviewRequest)
	case putReview(reviewId: Int, request: ReviewRequest)
	case getReviews
	case deleteReviewBy(id: Int)
}

extension FoodieRouter: EndPointType {
	var baseURL: URL {
		guard let url = URL(string: "https://buildweek-foodie1.herokuapp.com/auth/") else { fatalError("baseURL could not be configured")}
		return url
	}
	
	var path: String {
		switch self {
		case .register(_):
			return "register"
		case .login(_):
			return "login"
		case .putReview(let reviewId, _):
			return "api/\(reviewId)"
		case .getReviews,
			 .postReview:
			return "api"
		case .deleteReviewBy(let reviewId):
			return "api/\(reviewId)"
		}
	}
	
	var httpMethod: HTTPMethod {
		switch self {
		case .register(_),
			 .login(_),
			 .postReview(_):
			return .post
		case .putReview(_, _):
			return .put
		case .getReviews:
			return .get
		case .deleteReviewBy:
			return .delete
		}
	}
	
	var task: HTTPTask {
		switch self {
		case .register(let data),
			 .login(let data):
			let json = try? data.encode()
			return .requestParameters(bodyParameters: json)
		case .putReview(_, let data),
			 .postReview(let data):
			let json = try? data.encode()
			return .requestParameters(bodyParameters: json)
		default:
			return.request
		}
	}	
}
