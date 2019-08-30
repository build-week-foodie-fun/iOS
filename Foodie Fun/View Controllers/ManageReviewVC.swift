//
//  ManageReviewVC.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ManageReviewVC: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var imgView: UIImageView!
	@IBOutlet weak var restaurantTextField: UITextField!
	@IBOutlet weak var restaurantTypeTextField: UITextField!
	@IBOutlet weak var platterTextField: UITextField!
	@IBOutlet weak var ratingTextField: UITextField!
	@IBOutlet weak var priceTextField: UITextField!
	@IBOutlet weak var waitTimeTextField: UITextField!
	@IBOutlet weak var reviewTextView: UITextView!
	
	//MARK: - Properties
	
	private let textViewPlaceholder = """
									How did you order it?
									What did you think after the first bite?
									"""
	var review: Review?
	private var isEditMode: Bool {
		return review != nil
	}
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configViews()
		updateViews()
		loadReview()
	}
	
	//MARK: - IBActions
	
	@IBAction func addPhotoBtnTapped(_ sender: Any) {
	}
	
	@IBAction func saveBtnTapped(_ sender: Any) {
		postReview()
	}
	
	//MARK: - Helpers
	
	private func configViews() {
		ratingTextField.delegate = self
		priceTextField.delegate = self
		waitTimeTextField.delegate = self
		
		setupTextView()
	}
	
	private func updateViews() {
		guard let review = review else { return }
		title = "Edit Review"
		if !review.comments.isEmpty {
			reviewTextView.textColor = .black
		}
	}
	
	private func loadReview() {
		guard let review = review else { return }
		
		if let imgUrl = URL(string: review.photoOfOrder) {
			imgView.loadImage(from: imgUrl)
		}
		platterTextField.text = review.itemName
		restaurantTextField.text = review.restaurantName
		restaurantTypeTextField.text = review.restaurantType
		priceTextField.text = "\(review.price)"
		waitTimeTextField.text = review.waitTime
		ratingTextField.text = "\(review.foodRating)"
		reviewTextView.text = review.comments
	}
	
	private func resetViews() {
		imgView.image = UIImage(named: "undraw_street_food_hm5i")
		platterTextField.text = ""
		restaurantTextField.text = ""
		restaurantTypeTextField.text = ""
		priceTextField.text = ""
		waitTimeTextField.text = ""
		ratingTextField.text = ""
		reviewTextView.text = textViewPlaceholder
		reviewTextView.textColor = UIColor.lightGray	}
	
	private func newReview() -> ReviewRequest? {
		guard
			let restaurant = restaurantTextField.optionalText,
			let restaurantType = restaurantTypeTextField.optionalText,
			let platter = platterTextField.optionalText,
			let rating = ratingTextField.toDouble,
			let review = reviewTextView.text,
			let price = priceTextField.toDouble,
			let waitTime = waitTimeTextField.optionalText,
			let loggedInUserId = SettingsController.shared.loggedInUser?.id
			else { return nil }
		let reviewId = self.review?.id
		let createdDate = self.review?.createdAt
		
		return ReviewRequest(id: reviewId, restaurantName: restaurant, restaurantType: restaurantType, createdAt: createdDate, userId: loggedInUserId, itemName: platter, photoOfOrder: "https://www.pngfind.com/mpng/bRmhm_food-icon-food-icon-transparent-gif-hd-png/", foodRating: rating, comments: review, price: price, waitTime: waitTime, dateOfVisit: "")
	}
	
	private func postReview() {
		guard let newReview = newReview() else { return }
		
		if isEditMode {
			guard let reviewId = newReview.id else { return }
			NetworkManager.shared.putReview(forReview: reviewId, request: newReview) { (result, error) in
				DispatchQueue.main.async {
					guard result != nil else { return }

					self.navigationController?.popToRootViewController(animated: true)
				}
			}
		} else {
			NetworkManager.shared.postReview(request: newReview) { (result, error) in
				DispatchQueue.main.async {
					guard result != nil else { return }

					self.tabBarController?.selectedIndex = Tabs.profile.rawValue
				}
			}
		}
	}
}

//MARK: - TextField Delegate

extension ManageReviewVC: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if textField == priceTextField || textField == ratingTextField || textField == waitTimeTextField {
			let allowedCharacters = CharacterSet(charactersIn:"0123456789.")
			let characterSet = CharacterSet(charactersIn: string)
			let oldText = textField.optionalText ?? ""
			let newText = NSString(string: oldText).replacingCharacters(in: range, with: string)
			
			#warning("Work on 2 decimal places")
			if let rating = Double(newText), textField == ratingTextField && rating > 10 {
				return false
			}
			
			return allowedCharacters.isSuperset(of: characterSet)
		}
		return true
	}
}

//MARK: - TextView Delegate

extension ManageReviewVC: UITextViewDelegate {
	
	private func setupTextView() {
		reviewTextView.delegate = self
		reviewTextView.text = textViewPlaceholder
		reviewTextView.textColor = UIColor.lightGray
		reviewTextView.layer.borderWidth = 1
		reviewTextView.layer.borderColor = #colorLiteral(red: 0.9175765514, green: 0.9176866412, blue: 0.9175391197, alpha: 1)
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == .lightGray {
			textView.text = nil
			textView.textColor = .black
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = textViewPlaceholder
			textView.textColor = .lightGray
		}
	}
}
