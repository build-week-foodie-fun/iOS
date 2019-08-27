//
//  Extensions.swift
//  Foodie Fun
//
//  Created by Jeffrey Santana on 8/26/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

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

