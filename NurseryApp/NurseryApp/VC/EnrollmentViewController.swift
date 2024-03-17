//import UIKit
//import SnapKit
//
//class EnrollmentViewController: UIViewController {
//    
//    let enrollments: [String] = ["Yara", "Ahoud" ,"Ali", "Baby", "Ahmed", "Fatma"]
//    
//    lazy var enrollmentTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(EnrollmentTableViewCell.self, forCellReuseIdentifier: "EnrollmentCell")
//        tableView.separatorStyle = .none
//        tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = "Enrollments"
//        
//        setupUI()
//    }
//    
//    private func setupUI() {
//        view.addSubview(enrollmentTableView)
//        enrollmentTableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//}
//
//extension EnrollmentViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return enrollments.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "EnrollmentCell", for: indexPath) as! EnrollmentTableViewCell
//        cell.enrollmentLabel.text = enrollments[indexPath.row]
//        cell.statusButton.addTarget(self, action: #selector(statusButtonTapped(_:)), for: .touchUpInside)
//        cell.statusButton.tag = indexPath.row
//        return cell
//    }
//    
//    @objc func statusButtonTapped(_ sender: UIButton) {
//        let index = sender.tag
//        print("Status button tapped for enrollment: \(enrollments[index])")
//    }
//}
//
//class EnrollmentTableViewCell: UITableViewCell {
//    let enrollmentLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        label.textColor = .black
//        return label
//    }()
//    
//    let statusButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("View Status", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor(red: 0.0, green: 0.55, blue: 1.0, alpha: 1.0)
//        button.layer.cornerRadius = 8
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        return button
//    }()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        backgroundColor = .clear
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 2)
//        layer.shadowOpacity = 0.1
//        layer.shadowRadius = 2
//        
//        contentView.addSubview(enrollmentLabel)
//        contentView.addSubview(statusButton)
//        
//        enrollmentLabel.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.centerY.equalToSuperview()
//        }
//        
//        statusButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-20)
//            make.centerY.equalToSuperview()
//            make.width.equalTo(120)
//            make.height.equalTo(40)
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


import UIKit
import SnapKit

class EnrollmentViewController: UIViewController {
    
    let enrollments: [String] = ["Yara", "Ahoud" ,"Ali", "Baby", "Ahmed", "Fatma"]
    
    lazy var enrollmentTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EnrollmentTableViewCell.self, forCellReuseIdentifier: "EnrollmentCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular) 
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Enrollments"
        
        setupBackground()
        setupUI()
    }
    
    private func setupBackground() {
        view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupUI() {
        view.addSubview(enrollmentTableView)
        enrollmentTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension EnrollmentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return enrollments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnrollmentCell", for: indexPath) as! EnrollmentTableViewCell
        cell.enrollmentLabel.text = enrollments[indexPath.row]
        cell.statusButton.addTarget(self, action: #selector(statusButtonTapped(_:)), for: .touchUpInside)
        cell.statusButton.tag = indexPath.row
        return cell
    }
    
    @objc func statusButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        print("Status button tapped for enrollment: \(enrollments[index])")
    }
}

class EnrollmentTableViewCell: UITableViewCell {
    let enrollmentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("View Status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.55, blue: 1.0, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2
        
        contentView.addSubview(enrollmentLabel)
        contentView.addSubview(statusButton)
        
        enrollmentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        statusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//import UIKit
//import SnapKit
//
//class EnrollmentViewController: UIViewController {
//    
//    var enrollments: [EnrollmentResponse] = []
//    var token: String?
//    var userId: Int?
//    var childId: Int = 1
//    
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        token = UserDefaults.standard.string(forKey: "tokenAuth")
//        title = "Enrollments"
//        view.backgroundColor = .white
//        
//        fetchEnrollments()
//    }
//    
//    private func fetchEnrollments() {
//        guard let token = token else {
//            print("Token not available")
//            return
//        }
//        
//        // Assuming a placeholder user ID extraction logic
//        userId = getUserIdFromToken(token)
//        
//        guard let userId = userId else {
//            print("User ID not available")
//            return
//        }
//        
//        NetworkManager.shared.fetchChildEnrollments(userId: userId, childId: childId) { [weak self] result in
//            switch result {
//            case .success(let enrollments):
//                self?.enrollments = enrollments
//                self?.tableView.reloadData()
//            case .failure(let error):
//                print("Failed to fetch enrollments: \(error)")
//            }
//        }
//    }
//    
//    private func getUserIdFromToken(_ token: String) -> Int? {
//        
//        let tokenComponents = token.components(separatedBy: ".")
//        guard tokenComponents.count >= 2 else {
//            print("Invalid JWT token format")
//            return nil
//        }
//        
//        guard let payloadData = base64Decode(tokenComponents[1]),
//              let payloadJSON = try? JSONSerialization.jsonObject(with: payloadData, options: []) as? [String: Any] else {
//            print("Failed to decode JWT token payload")
//            return nil
//        }
//        
//        if let userIdString = payloadJSON["sub"] as? String,
//           let userId = Int(userIdString) {
//            return userId
//        } else {
//            print("User ID not found in JWT token payload")
//            return nil
//        }
//    }
//    
//    private func base64Decode(_ base64String: String) -> Data? {
//        let paddedLength = base64String.count + (4 - base64String.count % 4) % 4
//        let padding = String(repeating: "=", count: paddedLength - base64String.count)
//        let base64 = base64String + padding
//        return Data(base64Encoded: base64)
//    }
//}
