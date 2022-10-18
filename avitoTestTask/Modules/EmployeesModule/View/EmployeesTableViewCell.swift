import SnapKit
import UIKit

class EmployeesTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    private var nameLabel: UILabel = UILabel()
    private var phoneNumberLabel: UILabel = UILabel()
    private var skillsLabel: UILabel = UILabel()
    
    private var stackView: UIStackView = UIStackView()
    
    // MARK: - Properties
    
    private var constants: Constants = Constants()
    
    // MARK: - Functions

    func configureView(employee: Employee) {
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.319999963, green: 0.319999963, blue: 0.319999963, alpha: 1)
        
        addViews()
        configreStackView()
        configureNameLabel(name: employee.name)
        configurePhoneNumberLabel(phoneNumber: employee.phoneNumber)
        configureSkillsLabel(skills: employee.skills)
        configureLayouts()
    }
    
    // MARK: - Private Functions
    
    private func addViews() {
        addSubview(stackView)
    }
    
    private func configreStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(phoneNumberLabel)
        stackView.addArrangedSubview(skillsLabel)
    }
    
    private func configureNameLabel(name: String) {
        nameLabel.text = name
        nameLabel.font = UIFont(name: constants.avenirBlack, size: 38)
        nameLabel.numberOfLines = 0
    }
    
    private func configurePhoneNumberLabel(phoneNumber: String) {
        phoneNumberLabel.text = constants.getPhoneNumber(phoneNumber: phoneNumber)
        phoneNumberLabel.font = UIFont(name: constants.avenirBook, size: 16)
        phoneNumberLabel.numberOfLines = 0
    }
    
    private func configureSkillsLabel(skills: [String]) {
        skillsLabel.text = constants.getSkills(skills: skills)
        skillsLabel.font = UIFont(name: constants.avenirBook, size: 16)
        skillsLabel.numberOfLines = 0
    }
    
    private func configureLayouts() {
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
