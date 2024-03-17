import UIKit
import Kingfisher
import SnapKit

class DetailNurseryController: UIViewController {
    
    var nursery: Nursery?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        label.numberOfLines = 1
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
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
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
            make.width.equalTo(150)
            make.height.equalTo(150)
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
        detailLabel.text = " \(nursery.details)"
        detailLabel.numberOfLines = 20
    }
    
    private func applyStyling() {
        nameLabel.textColor = .black
        locationLabel.textColor = .darkGray
        detailLabel.textColor = .darkGray
        enrollButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    @objc private func enrollButtonTapped() {
        enrollButton.backgroundColor = .green
    }
}
