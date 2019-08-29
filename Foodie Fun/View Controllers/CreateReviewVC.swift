//
//  CreateReviewVC.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class CreateReviewVC: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var imgView: UIImageView!
	@IBOutlet weak var restaurantTextField: UITextField!
	@IBOutlet weak var restaurantTypeTextField: UITextField!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var ratingTextField: UITextField!
	@IBOutlet weak var priceTextField: UITextField!
	@IBOutlet weak var waitTimeTextField: UITextField!
	@IBOutlet weak var reviewTextView: UITextView!
	
	//MARK: - Properties
	
	private let textViewPlaceholder = """
									How did you order it?
									What did you think after the first bite?
									"""
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configViews()
	}
	
	//MARK: - IBActions
	
	@IBAction func addPhotoBtnTapped(_ sender: Any) {
	}
	
	@IBAction func saveBtnTapped(_ sender: Any) {
		guard let newReview = newReview() else { return }
		
		NetworkManager.shared.postReview(request: newReview) { (result, error) in
			DispatchQueue.main.async {
				guard result != nil else { return }
				
				self.tabBarController?.selectedIndex = Tabs.profile.rawValue
			}
		}
	}
	
	//MARK: - Helpers
	
	private func configViews() {
		ratingTextField.delegate = self
//		priceTextField.delegate = self
//		waitTimeTextField.delegate = self
		
		setupTextView()
	}
	
	private func newReview() -> ReviewRequest? {
		guard
//			let restaurant = restaurantTextField.optionalText,
//			let restaurantType = restaurantTypeTextField.optionalText,
			let title = titleTextField.optionalText,
			let rating = ratingTextField.toDouble,
			let review = reviewTextView.text,
//			let price = priceTextField.toDouble,
//			let waitTime = waitTimeTextField.optionalText,
			let loggedInUserId = SettingsController.shared.loggedInUser?.id
			else { return nil }
		
		return ReviewRequest(restaurantName: "L' Jeff", restaurantType: "Dominican Chiq", userId: loggedInUserId, itemName: title, photoOfOrder: "https://www.pngfind.com/mpng/bRmhm_food-icon-food-icon-transparent-gif-hd-png/", foodRating: rating, comments: review, price: 25.00, waitTime: "20", dateOfVisit: "")
		
//		return ReviewRequest(restaurantName: restaurant, restaurantType: restaurantType, userId: loggedInUserId, itemName: title, photoOfOrder: "", foodRating: rating, comments: review, price: price, waitTime: waitTime, dateOfVisit: "")
	}
	
}

extension CreateReviewVC: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if textField == priceTextField || textField == ratingTextField {
			let allowedCharacters = CharacterSet(charactersIn:"0123456789.")
			let characterSet = CharacterSet(charactersIn: string)
			let oldText = textField.optionalText ?? ""
			let newText = NSString(string: oldText).replacingCharacters(in: range, with: string)
			
			#warning("Work on 2 decimal places")
			if let rating = Double(newText), textField == ratingTextField && rating > 5 {
				return false
			}
			
			return allowedCharacters.isSuperset(of: characterSet)
		}
		return true
	}
}

extension CreateReviewVC: UITextViewDelegate {
	
	private func setupTextView() {
		reviewTextView.delegate = self
		reviewTextView.text = textViewPlaceholder
		reviewTextView.textColor = UIColor.lightGray
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == UIColor.lightGray {
			textView.text = nil
			textView.textColor = UIColor.black
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = textViewPlaceholder
			textView.textColor = UIColor.lightGray
		}
	}
}
