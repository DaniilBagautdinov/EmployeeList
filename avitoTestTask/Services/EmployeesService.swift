import Foundation
import SwiftyJSON

typealias EmployeesCompletion = (([Employee]?, Error?) -> Void)?

protocol EmployeesServiceProtocol {
    func getEmployees(completion: EmployeesCompletion)
}

class EmployeesService: EmployeesServiceProtocol {
    
    // MARK: - Properties
    
    private let constants: Constants = Constants()
    private let parser: EmployeesParser = EmployeesParser()
    
    private let cache = URLCache.shared
    private let configuration = URLSessionConfiguration.default
    
    // MARK: - Functions
    
    func getEmployees(completion: EmployeesCompletion) {
        guard let url = URL(string: constants.url) else { return }
        let session = URLSession(configuration: configuration)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let cacheData = cache.cachedResponse(for: request)?.data {
            completion?(parser.getEmployees(json: JSON(cacheData)), nil)
            
            return
        }
        
        session.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion?(nil, error)
            } else if let data = data {
                completion?(self?.parser.getEmployees(json: JSON(data)), nil)
                
                guard let response = response else { return }
                let cachedURLResponse = CachedURLResponse(response: response, data: data)
                self?.cache.storeCachedResponse(cachedURLResponse, for: request)
                UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "time")
            }
        }.resume()
    }
}
