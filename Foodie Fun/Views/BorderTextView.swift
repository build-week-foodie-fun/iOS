//
//  BorderTextView.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

@IBDesignable
class BorderTextView: UITextView {
	
	override func awakeFromNib() {
		setupView()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}
	
	func setupView() {
		layer.borderWidth = 1
		layer.borderColor = UIColor.lightGray.cgColor
		layer.cornerRadius = 10
		layer.masksToBounds = true
		
	}
	
}
