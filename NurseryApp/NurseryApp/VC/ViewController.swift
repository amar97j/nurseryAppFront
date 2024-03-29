import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nursery")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        return blurView
    }()
    
    let topContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 5
        return view
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
//        label.text = "Welcome to NURSERIA"
        label.text = "Nurseria"
        label.textColor = #colorLiteral(red: 0.6488326192, green: 0.5253301263, blue: 0.7380740047, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 33, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nursery")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account? Sign Up"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(topContainerView)
        topContainerView.addSubview(topLabel)
        topContainerView.addSubview(imageView)
        
        topContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.width.equalTo(300)
            make.height.equalTo(320)
        }
        
        topLabel.snp.makeConstraints { make in
            make.centerX.equalTo(topContainerView)
            make.top.equalTo(topContainerView).offset(40)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(topContainerView)
            make.top.equalTo(topLabel.snp.bottom).offset(40)
            make.width.height.equalTo(200)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.width.equalTo(imageView)
            make.height.equalTo(50)
        }
        
        view.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signUpLabelTapped))
        signUpLabel.addGestureRecognizer(tapGesture)
        
        topLabel.alpha = 0.0
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut, animations: {
            self.topLabel.alpha = 1.0
        }, completion: nil)
    }
    
    @objc private func signInButtonTapped() {
        let signInViewController = SignInViewController()
        
        if let sheet = signInViewController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
            sheet.prefersGrabberVisible = true
        }
        
        navigationController?.present(signInViewController, animated: true, completion: nil)
    }
    
    @objc private func signUpLabelTapped() {
        let signUpViewController = SignUpViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
