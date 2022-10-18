import Foundation
import SwiftyJSON

class EmployeesParser {
    
    // MARK: - Functions
    
    func getEmployees(json: JSON) -> [Employee] {
        let companyName = json[Keys.company.rawValue][Keys.name.rawValue].stringValue
        UserDefaults.standard.set(companyName, forKey: "companyName")
        
        var result: [Employee] = []
        
        for employeeJson in json[Keys.company.rawValue][Keys.employees.rawValue].arrayValue {
            result.append(getEmployee(json: employeeJson))
        }
        
        return result.sorted {
            $0.name < $1.name
        }
    }
    
    // MARK: - Private Functions
    
    private func getEmployee(json: JSON) -> Employee {
        return Employee(name: json[Keys.name.rawValue].stringValue,
                        phoneNumber: json[Keys.phoneNumber.rawValue].stringValue,
                        skills: getSkills(json: json))
    }
    
    private func getSkills(json: JSON) -> [String] {
        var result: [String] = []
        
        for skill in json[Keys.skills.rawValue].arrayValue {
            result.append(skill.stringValue)
        }
        
        return result
    }
    
    // MARK: - Keys
    
    private enum Keys: String {
        case company = "company"
        case employees = "employees"
        case name = "name"
        case phoneNumber = "phone_number"
        case skills = "skills"
    }
}
