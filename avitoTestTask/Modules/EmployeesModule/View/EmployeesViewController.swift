import SnapKit
import UIKit

class EmployeesViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var tableView: UITableView = UITableView(frame: CGRect(), style: .insetGrouped)
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private var errorView: UIView = UIView()
    private var errorImageView: UIImageView = UIImageView()
    private var errorTitleLabel: UILabel = UILabel()
    private var errorMessageLabel: UILabel = UILabel()
    private var errorButton: UIButton = CustomButton().configureButton()
    
    // MARK: - Properties
    
    private let constants: Constants = Constants()
    
    // MARK: - View Model
    
    var viewModel: EmployeesViewModelProtocol! {
        didSet {
            viewModel.employeeIsChanged = { [weak self] in
                self?.reloadTableView()
            }
            viewModel.activityIndicatorFlagIsChanged = { [weak self] viewModel in
                self?.activityIndicatorPresent(viewModel: viewModel)
            }
            viewModel.errorDesriptionIsChanged = { [weak self] viewModel in
                self?.errorViewPresent(message: viewModel.errorDescription)
            }
        }
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private Functions
    
    private func configureView() {
        viewModel.getEmoloyees()
        view.backgroundColor = .white

        addViews()
        configureTableView()
        configureErrorView()
        configureLayouts()
    }
    
    private func addViews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EmployeesTableViewCell.self, forCellReuseIdentifier: constants.cellReuseIdentifier)
        
        tableView.backgroundColor = .white
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func configureErrorView() {
        errorView.isHidden = true
        errorView.backgroundColor = .white
        
        errorView.addSubview(errorImageView)
        errorView.addSubview(errorTitleLabel)
        errorView.addSubview(errorMessageLabel)
        errorView.addSubview(errorButton)
        
        configureErrorImageView()
        configureErrorTitleLabel()
        configureErrorButton()
    }
    
    private func configureErrorImageView() {
        errorImageView.image = #imageLiteral(resourceName: "Vector")
    }
    
    private func configureErrorTitleLabel() {
        errorTitleLabel.text = constants.errorTitle
        errorTitleLabel.font = UIFont(name: constants.avenirBook, size: 26)
        errorTitleLabel.textAlignment = .center
        errorTitleLabel.numberOfLines = 0
    }
    
    private func configureErrorMessageLabel(message: String) {
        errorMessageLabel.text = message
        errorMessageLabel.font = UIFont(name: constants.avenirBook, size: 16)
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
    }
    
    private func configureErrorButton() {
        errorButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func configureLayouts() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        errorView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        errorImageView.snp.makeConstraints { make in
            make.height.width.equalTo(71)
            make.centerX.equalTo(errorView.snp.centerX)
        }
        errorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(errorImageView.snp.bottom).offset(24)
            make.trailing.leading.equalToSuperview().inset(16)
        }
        errorMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(errorTitleLabel.snp.bottom).offset(24)
            make.centerY.equalTo(errorView.snp.centerY)
            make.trailing.leading.equalToSuperview().inset(16)
        }
        errorButton.snp.makeConstraints { make in
            make.top.equalTo(errorMessageLabel.snp.bottom).offset(24)
            make.trailing.leading.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            
            guard let companyName = self?.constants.companyName else { return }
            self?.title = UserDefaults.standard.string(forKey: companyName)
        }
    }
    
    private func activityIndicatorPresent(viewModel: EmployeesViewModelProtocol) {
        DispatchQueue.main.async { [weak self] in
            if viewModel.activityIndicatorFlag {
                self?.activityIndicator.startAnimating()
                self?.activityIndicator.isHidden = false
                self?.tableView.isHidden = true
            } else {
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.tableView.isHidden = false
            }
        }
    }
    
    private func errorViewPresent(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.configureErrorMessageLabel(message: message)
            self?.errorView.isHidden = false
        }
    }
    
    // MARK: - objc
    
    @objc private func didTapButton() {
        viewModel.getEmoloyees()
        
        errorView.isHidden = true
    }
}

// MARK: - UITableViewDataSource

extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: constants.cellReuseIdentifier, for: indexPath)
                as? EmployeesTableViewCell
                    else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.configureView(employee: viewModel.employees[indexPath.row])
        return cell
    }
}
