//
//  OperationQueue.swift
//  NetWorker
//
//  Created by Полина Скалкина on 18.03.2023.
//

import Foundation

final class FetchingOperations {
  lazy var fetchingTasks: [IndexPath: Operation] = [:]
  lazy var fetchingQueue: OperationQueue = {
    var queue = OperationQueue()
    queue.name = "FetchingDataQueue"
    queue.maxConcurrentOperationCount = 4
    return queue
  }()
}

final class FetchingDataOperation<T>: Operation where T: Decodable {
  private let lockQueue = DispatchQueue(
    label: "com.swiftlee.asyncoperation",
    attributes: .concurrent
  )
  
  private let request: URLRequest?
  private let completion: (Result<T, NetWorkerFetchingError>) -> Void
  
  private let delayCounter: ExponentialBackoffDelayCalculator
  
  init(
    request: URLRequest?,
    delayCounter: ExponentialBackoffDelayCalculator,
    completion: @escaping (Result<T, NetWorkerFetchingError>) -> Void
  ) {
    self.request = request
    self.delayCounter = delayCounter
    self.completion = completion
  }
  
  override var isAsynchronous: Bool {
    true
  }
  
  private var _isExecuting: Bool = false
  private(set) override var isExecuting: Bool {
    get {
      lockQueue.sync { () -> Bool in
        _isExecuting
      }
    }
    set {
      willChangeValue(forKey: "isExecuting")
      lockQueue.sync(flags: [.barrier]) {
        _isExecuting = newValue
      }
      didChangeValue(forKey: "isExecuting")
    }
  }
  
  private var _isFinished: Bool = false
  private(set) override var isFinished: Bool {
    get {
      lockQueue.sync { () -> Bool in
        _isFinished
      }
    }
    set {
      willChangeValue(forKey: "isFinished")
      lockQueue.sync(flags: [.barrier]) {
        _isFinished = newValue
      }
      didChangeValue(forKey: "isFinished")
    }
  }
  
  override func start() {
    isFinished = false
    isExecuting = true
    main()
  }
  
  override func main() {
    guard let request = request else {
      completion(.failure(NetWorkerFetchingError.unableToMakeRequest))
      finish()
      return
    }
    
    URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
      
      if let error = error {
        self?.completion(.failure(.serverError(error: error)))
        
        guard let self = self else {
          self?.finish()
          return
        }
        
        let newDelay: Double = self.delayCounter.countDelay()
        
        sleep(UInt32(newDelay))
        self.finish()
        self.start()
        return
      }
      
      self?.delayCounter.resetDelay()
      
      do {
        guard let data = data else {
          self?.completion(.failure(NetWorkerFetchingError.noResponseData))
          self?.finish()
          return
        }
        
        let result = try JSONDecoder().decode(T.self, from: data)
        self?.completion(.success(result))
        self?.finish()
      } catch {
        self?.completion(.failure(.parsingError))
        self?.finish()
      }
    }.resume()
  }
  
  func finish() {
    isExecuting = false
    isFinished = true
  }
}
