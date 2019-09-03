//
//  RoundedImage.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 9/2/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImage: UIImageView {
	
	override func awakeFromNib() {
		setupView()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}
	
	func setupView() {
		layer.cornerRadius = layer.frame.width / 2
		layer.masksToBounds = true
		layer.borderColor = UIColor.lightGray.cgColor
		layer.borderWidth = 3
		
		contentMode = .scaleAspectFill
	}
	
}
