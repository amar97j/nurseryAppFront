import UIKit
import Kingfisher
import SnapKit

class DetailNurseryController: UIViewController {
    
    var nursery: Nursery?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 28)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    let enrollButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enroll", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 3
        button.addTarget(self, action: #selector(enrollButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Nursery Details"
        
        setupUI()
        updateUI()
        
        if let imageURLString = nursery?.imageUrl, let imageUrl = URL(string: imageURLString) {
            imageView.kf.setImage(with: imageUrl)
        }
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(imageView.snp.width).multipliedBy(0.7)
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(detailLabel)
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(enrollButton)
        enrollButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(imageView.snp.width)
            make.height.equalTo(50)
            make.top.equalTo(stackView.snp.bottom).offset(30)
        }
        
        applyStyling()
    }
    
    private func updateUI() {
        guard let nursery = nursery else { return }
        
        nameLabel.text = nursery.name
        locationLabel.text = "Location: \(nursery.location)"
        detailLabel.text = "Detail: \(nursery.details)"
    }
    
    private func applyStyling() {
        nameLabel.textColor = .black
        locationLabel.textColor = .darkGray
        detailLabel.textColor = .darkGray
        
        enrollButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    @objc private func enrollButtonTapped() {
        let enrollmentViewController = EnrollmentViewController()
        self.present(enrollmentViewController, animated: true)
    }
}
