//
//  APIConfiguration.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 20.07.22.
//

import Foundation

final class APIConfiguration {

	private let configuration: [String: String]

	static let shared = APIConfiguration()

	var apiBaseURL: String {
		configuration["SPOONACULAR_API_BASE_URL"]!
	}

	var apiAuthValue: String {
		configuration["SPOONACULAR_API_KEY"]!
	}

	var apiAuthKey: String {
		"x-api-key"
	}

	var apiBaseScheme: String {
		"https"
	}

	private init() {
		if let infoPlistPath = Bundle.main.path(forResource: "APIConfig", ofType: "plist"),
		   let dict = NSDictionary(contentsOfFile: infoPlistPath) as? [String: String] {
			configuration = dict
		} else {
			configuration = [String: String]()
		}
	}
}
