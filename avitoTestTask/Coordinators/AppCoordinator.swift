import UIKit

final class AppCoordinator: AbstractCoordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    var coordinators: [AbstractCoordinator] = []
    
    // MARK: - UIWindow
    
    private let window: UIWindow?
    
    // MARK: - Init
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Start
    
    func start() {
        assemble()
    }
    
    // MARK: - Private Functions
    
    private func assemble() {
        window?.rootViewController = navigationController
        
        let employeesService = EmployeesService()
        let employeesViewModel = EmployeesViewModel(service: employeesService)
        let employeesView = EmployeesViewController()
        employeesView.viewModel = employeesViewModel
        
        navigationController.show(employeesView, sender: self)
    }
}
