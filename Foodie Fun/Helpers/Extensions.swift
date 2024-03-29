//
//  Extensions.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

//MARK: - Codable

extension Decodable {
	static func decode(data: Data) throws -> Self {
		let decoder = JSONDecoder()
		return try decoder.decode(Self.self, from: data)
	}
}

extension Encodable {
	func encode() throws -> Data {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		encoder.keyEncodingStrategy = .convertToSnakeCase
		return try encoder.encode(self)
	}
}

extension UITextField {
	var optionalText: String? {
		let trimmedText = self.text?.trimmingCharacters(in: .whitespacesAndNewlines)
		return (trimmedText ?? "").isEmpty ? nil : trimmedText
	}
	
	var toDouble: Double? {
		guard let text = self.optionalText else { return nil }
		return Double(text)
	}
}

extension UIImageView {
	func loadImage(from url: URL) {
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
