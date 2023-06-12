//
//  NetWorker.swift
//  NetWorker
//
//  Created by Полина Скалкина on 18.03.2023.
//

public class NetWorkerService: NetWorkerServiceProtocol {
  let host: String

  private lazy var opQueue = FetchingOperations()
  private lazy var delayCounter = ExponentialBackoffDelayCalculator()
  private lazy var requestCreator = RequestCreator()

  public init(host: String) {
    self.host = host
  }

  public func perform<Model>(
    type: RequestType,
    path: String,
    params: [String: String],
    completion: @escaping (Result<Model, NetWorkerFetchingError>) -> ()
  ) where Model : Decodable {
    let operation = FetchingDataOperation(
      request: requestCreator.createRequest(type: type, host: host, path: path, params: params),
      delayCounter: delayCounter,
      completion: completion
    )
    opQueue.fetchingQueue.addOperation(operation)
  }
}
