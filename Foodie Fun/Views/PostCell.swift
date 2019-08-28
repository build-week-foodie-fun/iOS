//
//  PostCell.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/28/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
	
	//MARK: - IBOutlets
	
	@IBOutlet weak var imgView: UIImageView!
	
	//MARK: - Properties
	
	var post: Review? {
		didSet {
			configCell()
		}
	}
	
	//MARK: - IBActions
	
	
	//MARK: - Helpers
	
	private func configCell() {
		guard let post = post, let photoURL = URL(string: post.photoOfOrder) else { return }
		
		imgView.loadImage(from: photoURL)
	}
	
}
