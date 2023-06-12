//
//  NetworkServiceProtocol.swift
//  NetWorker
//
//  Created by Полина Скалкина on 18.03.2023.
//

import Foundation

protocol NetWorkerServiceProtocol {

  var host: String { get }

  func perform<Model>(
    type: RequestType,
    path: String,
    params: [String: String],
    completion: @escaping (Result<Model, NetWorkerFetchingError>) -> ()
  ) where Model : Decodable
}
