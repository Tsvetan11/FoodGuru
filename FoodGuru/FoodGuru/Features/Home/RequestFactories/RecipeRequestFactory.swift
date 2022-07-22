//
//  RecipeRequestFactory.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 20.07.22.
//

import Foundation

protocol RecipeRequestFactory {
	func getRandom() -> APIRequest
	func getInformation(id: Int) -> APIRequest
}

struct RecipeRequestFactoryImpl: RecipeRequestFactory {

	enum RecipeEndpoint {
		case getRandom
		case getInformation(id: Int)
	}

	func getRandom() -> APIRequest {
		APIRequest(path: RecipeEndpoint.getRandom.path,
				method: .get)
		.apiKey()
		.param(key: "number", value: "1")
	}

	func getInformation(id: Int) -> APIRequest {
		APIRequest(path: RecipeEndpoint.getInformation(id: id).path,
				method: .get)
		.apiKey()
	}
}

// MARK: - Endpoint paths

private extension RecipeRequestFactoryImpl.RecipeEndpoint {
	var path: String {
		switch self {
		case .getRandom:
			return "/recipes/random"
		case .getInformation(let id):
			return "/recipes/\(id)/information"
		}
	}

	var method: HTTPMethod {
		switch self {
		case .getRandom, .getInformation:
			return .get
		}
	}
}

