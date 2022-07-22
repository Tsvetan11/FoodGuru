//
//  HTTPClient.swift
//  FoodGuru
//
//  Created by Tsvetan Tsvetanov on 20.07.22.
//

import Foundation

protocol HTTPClient {
	func sendRequest<T: Decodable>(request: APIRequest, responseModel: T.Type) async throws -> T
}

final class HTTPClientImpl: HTTPClient {

	func sendRequest<T: Decodable>(request: APIRequest, responseModel: T.Type) async throws -> T {

		var urlComponents = URLComponents()
		urlComponents.scheme = request.scheme
		urlComponents.host = request.host
		urlComponents.path = request.path

		if let params = request.params {
			urlComponents.queryItems = params.map { (key, value) in
				URLQueryItem(name: key, value: value)
			}
		}

		guard let url = urlComponents.url else {
			throw APIError.invalidURL
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = request.method.rawValue
		urlRequest.allHTTPHeaderFields = request.header

		if let body = request.body {
			urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
		}

		do {
			let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
			guard let response = response as? HTTPURLResponse else {
				throw APIError.noResponse
			}
			switch response.statusCode {
			case 200...299:
				guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
					throw APIError.decode
				}
				return decodedResponse
			case 401:
				throw APIError.unauthorized
			default:
				throw APIError.unexpectedStatusCode
			}
		} catch {
			guard let error = error as? APIError else {
				throw APIError.unknown
			}

			throw error
		}
	}
}
