//
//  RoundedButton.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
	
	override func awakeFromNib() {
		setupView()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setupView()
	}
	
	func setupView() {
		layer.cornerRadius = 10
		layer.masksToBounds = true
		
		heightAnchor.constraint(equalToConstant: 40).isActive = true
	}
	
}
