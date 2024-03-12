//
//  SignInViewController.swift
//  BankApiCornerStone
//
//  Created by Amora J. F. on 11/03/2024.
//

import UIKit
import Eureka

class SignInViewController: FormViewController {
    var token: String?
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupForm()
    }
    
    private func setupForm() {
        
        form +++ Section("Sign In")
        
        <<< TextRow() { row in
            row.title = "📧 username"
            row.placeholder = "Enter your email"
            row.tag = "username"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< PasswordRow() { row in
            row.title = "🔐 Password"
            row.placeholder = "Enter your password"
            row.tag = "password"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< ButtonRow() { row in
            row.title = "Sign In"
            row.onCellSelection { cell, row in
                print("Button cell tapped")
                self.submitTapped()
            }
        }
    }
    
    @objc func submitTapped() {
        let errors = form.validate()
        guard errors.isEmpty else {
            presentAlertWithTitle(title: "🆘", message: "One of the text fields is empty.")
            return
        }
        
        guard let usernameRow: TextRow = form.rowBy(tag: "username"),
              let passwordRow: PasswordRow = form.rowBy(tag: "password") else {
            return
        }
        
        let username = usernameRow.value ?? ""
        let password = passwordRow.value ?? ""
        
        let user = User(name: "", username: username, email: "", password: password)
        
        NetworkManager.shared.signIn(user: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tokenResponse):
                    print("Token:", tokenResponse.token)
                    let registerVC = RegisterChildViewController()
                    registerVC.token = tokenResponse.token
                    registerVC.modalPresentationStyle = .pageSheet
                    self.present(registerVC, animated: true)
                case .failure(let error):
                    print("Error:", error)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

