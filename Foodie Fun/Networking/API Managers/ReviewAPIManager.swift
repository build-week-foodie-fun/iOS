//
//  ReviewAPIManager.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

extension NetworkManager {
	func postReview(request: ReviewRequest, completion: @escaping (_ reviews: ReturnID?, _ error: String?) -> Void) {
		router.request(.postReview(request: request)) { (data, response, error) in
			let returnRequest = self.getObject(data, response, error, ReturnID.self)
			completion(returnRequest.0, returnRequest.1)
		}
	}
	
	func putReview(forReview id: Int, request: ReviewRequest, completion: @escaping (_ reviews: Bool?, _ error: String?) -> Void) {
		router.request(.putReview(reviewId: id, request: request)) { (data, response, error) in
			let returnRequest = self.getObject(data, response, error, Bool.self)
			completion(returnRequest.0, returnRequest.1)
		}
	}
	
	func getAllReviews(completion: @escaping (_ reviews: [Review]?, _ error: String?) -> Void) {
		router.request(.getReviews) { (data, response, error) in
			let returnRequest = self.getObject(data, response, error, UnnecessaryWrapper.self)
			completion(returnRequest.0?.data, returnRequest.1)
		}
	}
	
	func deleteReview(reviewId: Int, completion: @escaping (_ reviews: Bool?, _ error: String?) -> ()) {
		router.request(.deleteReviewBy(id: reviewId)) { (data, response, error) in
			let returnRequest = self.getObject(data, response, error, Bool.self)
			completion(returnRequest.0, returnRequest.1)
		}
	}
}
