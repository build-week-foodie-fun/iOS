//
//  BorderLabel.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

@IBDesignable
class BorderLabel: UILabel {
	
	override func awakeFromNib() {
		setupView()
	}
	
	override func drawText(in rect: CGRect) {
		let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
		super.drawText(in: rect.inset(by: insets))
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
		
		heightAnchor.constraint(equalToConstant: 30).isActive = true
	}
	
}
