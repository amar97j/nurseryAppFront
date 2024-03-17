
//import UIKit
//import SnapKit
//
//class ChildViewController: UIViewController {
//    var token: String?
//    
//    private let nameLabel = UILabel()
//    private let ageLabel = UILabel()
//    private let caseIdLabel = UILabel()
//    private let caseNameLabel = UILabel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        token = UserDefaults.standard.string(forKey: "tokenAuth")
//
//        setupNavBar()
//        setUpNavigationBar()
//        setupUI()
//        
//       
//    }
//    
//    func setupNavBar() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "plus"),
//            style: .plain,
//            target: self,
//            action: #selector(navChildRegister)
//        )
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.darkGray
//    }
//    
//    @objc func navChildRegister() {
//        let childVc = RegisterChildViewController()
//        childVc.modalPresentationStyle = .popover
//        self.present(childVc, animated: true)
//    }
//    
//    func setUpNavigationBar() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//    }
//    
//    func setupUI() {
//        view.addSubview(nameLabel)
//        view.addSubview(ageLabel)
//        view.addSubview(caseIdLabel)
//        view.addSubview(caseNameLabel)
//        
//        nameLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
//        }
//        
//        ageLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(nameLabel.snp.bottom).offset(20)
//        }
//        
//        caseIdLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(ageLabel.snp.bottom).offset(20)
//        }
//        
//        caseNameLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(caseIdLabel.snp.bottom).offset(20)
//        }
//    }
//    
//    func fetchChildInfo(userId: Int) {
//        guard let token = token else {
//            return
//        }
//        NetworkManager.shared.fetchChildInfo(token: token, userId: userId) { result in
//            switch result {
//            case .success(let children):
//                if let child = children.first {
//                    DispatchQueue.main.async {
//                        self.nameLabel.text = child.name
//                        self.ageLabel.text = "Age: \(child.age)"
//                        if let childCaseId = child.childCaseId {
//                            self.caseIdLabel.text = "Case ID: \(childCaseId.id)"
//                            self.caseNameLabel.text = "Case Name: \(childCaseId.name)"
//                        } else {
//                            self.caseIdLabel.text = "Case ID: N/A"
//                            self.caseNameLabel.text = "Case Name: N/A"
//                        }
//                    }
//                } else {
//                    print("No child found")
//                }
//            case .failure(let error):
//                print("Error fetching child info: \(error)")
//            }
//        }
//    }
//}


import UIKit
import SnapKit

class ChildViewController: UIViewController {
    var token: String?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "nursery"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        return label
    }()
    
    private let caseIdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        return label
    }()
    
    private let caseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(blurEffectView)
        view.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(ageLabel)
        containerView.addSubview(caseIdLabel)
        containerView.addSubview(caseNameLabel)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(300)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerView.snp.top).offset(60)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        
         caseNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(ageLabel.snp.bottom).offset(30)
        }
        
//        caseIdLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(caseIdLabel.snp.bottom).offset(20)
//        }
        
        token = UserDefaults.standard.string(forKey: "tokenAuth")

        setupNavBar()
        setUpNavigationBar()
        fetchDummyChildInfo()
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(navChildRegister)
        )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.darkGray
    }
    
    @objc func navChildRegister() {
        let childVc = RegisterChildViewController()
        childVc.modalPresentationStyle = .popover
        self.present(childVc, animated: true)
    }
    
    func setUpNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func fetchDummyChildInfo() {
        let dummyChild = Child(name: "Yara", age: "5", caseId: 1, childCaseId: ChildCaseId(id: 1, name: "Regular"))
        
        nameLabel.text = dummyChild.name
        ageLabel.text = "Age: \(dummyChild.age)"
        if let childCaseId = dummyChild.childCaseId {
            //caseIdLabel.text = "Case ID: \(childCaseId.name)"
            caseNameLabel.text = "Case Name: \(childCaseId.name)"
        } else {
            caseIdLabel.text = "Case ID: N/A"
            caseNameLabel.text = "Case Name: N/A"
        }
    }
}
