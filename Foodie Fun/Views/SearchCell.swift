//
//  SearchCell.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var imgView: UIImageView!
	
	//MARK: - Properties
	
	var review: Review? {
		didSet {
			configCell()
		}
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	private func configCell() {
		imgView.layer.borderWidth = 1
		imgView.layer.borderColor = UIColor.lightGray.cgColor
		
		guard let review = review, let foodUrl = URL(string: review.photoOfOrder) else { return }
		
		imgView.loadImage(from: foodUrl)
	}
}
