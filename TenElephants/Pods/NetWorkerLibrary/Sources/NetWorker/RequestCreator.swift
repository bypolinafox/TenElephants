//
//  RequestCreator.swift
//  NetWorker
//
//  Created by Полина Скалкина on 18.03.2023.
//

import Foundation

struct RequestCreator {
  func createRequest(type: RequestType, host: String, path: String, params: [String: String]) -> URLRequest? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = host
    urlComponents.path = path

    var queryItems: [URLQueryItem] = []

    for (paramName, paramValue) in params {
      queryItems.append(URLQueryItem(name: paramName, value: paramValue))
    }

    urlComponents.queryItems = queryItems
    guard let url = urlComponents.url else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = type.rawValue
    return request
  }
}
