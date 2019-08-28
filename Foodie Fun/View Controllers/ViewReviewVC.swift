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
	@IBOutlet weak var commentLbl: UILabel!
	
	//MARK: - Properties
	
	var post: Review?
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateViews()
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	private func updateViews() {
		guard let post = post else { return }
		
		imgView.loadImage(from: post.photoOfOrder)
		titleLbl.text = post.itemName.capitalized
		ratingLbl.text = "\(post.foodRating)/10"
		commentLbl.text = post.comments
	}
}
