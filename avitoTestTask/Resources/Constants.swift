import Foundation

class Constants {
    
    // MARK: - Network
    
    let url: String = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    // MARK: - Employees View Controller
    
    let errorTitle: String = "Faild to connect"
    
    let companyName: String = UserDefaults.standard.string(forKey: "companyName") ?? ""
    
    let cellReuseIdentifier: String = "cell"
    
    let avenirBook: String = "Avenir-Book"
    
    // MARK: - Employees Table View Cell
    
    let avenirBlack: String = "Avenir-Black"
    
    func getPhoneNumber(phoneNumber: String) -> String {
        "Phone number: \(phoneNumber)"
    }
    
    func getSkills(skills: [String]) -> String {
        var result: String = ""
        
        for i in 0..<skills.count {
            i == skills.count - 1 ? (result += "\(skills[i])") : (result += "\(skills[i]), ")
        }
        
        return "Skills: \(result)"
    }
}
