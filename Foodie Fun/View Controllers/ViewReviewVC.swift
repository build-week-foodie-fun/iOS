//
//  ViewReviewVC.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ViewReviewVC: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var imgView: UIImageView!
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var ratingLbl: UILabel!
	@IBOutlet weak var commentLbl: UITextView!
	
	//MARK: - Properties
	
	var review: Review?
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateViews()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let manageReviewVC = segue.destination as? manageReviewVC {
			manageReviewVC.review = review
		}
	}
	
	//MARK: - IBActions
	
	@IBAction func deleteReview(_ sender: Any) {
		guard let post = review else { return }
		
		let confirmAlert = UIAlertController(title: "Delete Review", message: "Are you sure you would like to delete this review?", preferredStyle: .alert)
		let confirmAction = UIAlertAction(title: "confirm", style: .destructive) { (_) in
			NetworkManager.shared.deleteReview(reviewId: post.id) { (result, error) in
				if let result = result, result {
					DispatchQueue.main.async {
						self.navigationController?.popViewController(animated: true)
					}
				}
			}
		}
		let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
		
		confirmAlert.addAction(confirmAction)
		confirmAlert.addAction(cancelAction)
		present(confirmAlert, animated: true, completion: nil)
		
	}
	
	//MARK: - Helpers
	
	private func updateViews() {
		guard let post = review else { return }
		
		titleLbl.text = post.itemName.capitalized
		ratingLbl.text = "\(post.foodRating)/10"
		commentLbl.text = post.comments
		
		guard let photoURL = URL(string: post.photoOfOrder) else { return }
		
		imgView.loadImage(from: photoURL)
	}
}
