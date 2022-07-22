//
//  APIError.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 20.07.22.
//

import Foundation

enum APIError: Error {
	case decode
	case invalidURL
	case noResponse
	case unauthorized
	case unexpectedStatusCode
	case unknown

	var customMessage: String {
		switch self {
		case .decode:
			return "Decode error"
		case .unauthorized:
			return "Session expired"
		default:
			return "Unknown error"
		}
	}
}
