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
	@IBOutlet weak var platterLbl: BorderLabel!
	@IBOutlet weak var ratingLbl: BorderLabel!
	@IBOutlet weak var waitTimeLbl: BorderLabel!
	@IBOutlet weak var priceLbl: BorderLabel!
	@IBOutlet weak var commentLbl: UITextView!
	
	//MARK: - Properties
	
	var review: Review?
	private var currencyFormatter: NumberFormatter {
		let formatter = NumberFormatter()
		formatter.locale = Locale.current
		formatter.numberStyle = .currency
		return formatter
	}
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateViews()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let manageReviewVC = segue.destination as? ManageReviewVC {
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
		
		title = post.restaurantName
		platterLbl.text = post.itemName.capitalized
		ratingLbl.text = "\(post.foodRating)/10"
		waitTimeLbl.text = post.waitTime
		priceLbl.text = currencyFormatter.string(from: NSNumber(value: post.price))
		commentLbl.text = post.comments
		
		if review?.userId != SettingsController.shared.loggedInUser?.id {
			navigationItem.rightBarButtonItems?.removeAll()
		}
		
		guard let photoURL = URL(string: post.photoOfOrder) else { return }
		
		imgView.loadImage(from: photoURL)
	}
}
