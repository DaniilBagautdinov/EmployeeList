import Foundation

protocol EmployeesViewModelProtocol {
    var employees: [Employee] { get set }
    var activityIndicatorFlag: Bool { get set }
    var errorDescription: String { get set }
    
    var employeeIsChanged: (() -> Void)? { get set }
    var activityIndicatorFlagIsChanged: ((EmployeesViewModelProtocol) -> Void)? { get set }
    var errorDesriptionIsChanged: ((EmployeesViewModelProtocol) -> Void)? { get set }
    
    func getEmoloyees()
}

class EmployeesViewModel: EmployeesViewModelProtocol {
    
    // MARK: - Properties
    
    var employees: [Employee] = [] {
        didSet {
            employeeIsChanged?()
        }
    }
    
    var activityIndicatorFlag: Bool = false {
        didSet {
            activityIndicatorFlagIsChanged?(self)
        }
    }
    
    var errorDescription: String = "" {
        didSet {
            errorDesriptionIsChanged?(self)
        }
    }
    
    var employeeIsChanged: (() -> Void)?
    var activityIndicatorFlagIsChanged: ((EmployeesViewModelProtocol) -> Void)?
    var errorDesriptionIsChanged: ((EmployeesViewModelProtocol) -> Void)?
    
    private var service: EmployeesServiceProtocol
    
    // MARK: - Init
    
    init(service: EmployeesServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Functions
    
    func getEmoloyees() {
        activityIndicatorFlag = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.service.getEmployees { [weak self] employees, error in
                if let error = error {
                    self?.errorDescription = error.localizedDescription
                } else if let employees = employees {
                    self?.employees = employees
                    self?.activityIndicatorFlag = false
                }
            }
        }
    }
}
