//
//  SignUpViewController.swift
//  BankApiCornerStone
//
//  Created by Amora J. F. on 11/03/2024.
//

import UIKit
import Eureka

class SignUpViewController: FormViewController {
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupForm()
    }
    
    private func setupForm() {
        form +++ Section("Sign Up")
        <<< TextRow() { row in
            row.title = "📝 name"
            row.placeholder = "Enter your name"
            row.tag = "name"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
        <<< TextRow() { row in
            row.title = "📝 Username"
            row.placeholder = "Enter your name"
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
        <<< EmailRow() { row in
            row.title = "📧 Email"
            row.placeholder = "Enter your email"
            row.tag = "email"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< ButtonRow() { row in
            row.title = "Sign Up"
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
        
        guard let nameRow: TextRow = form.rowBy(tag: "name"),
              let passwordRow: PasswordRow = form.rowBy(tag: "password"),
              let emailRow: EmailRow = form.rowBy(tag: "email") else {
            return
        }
        
        let name = nameRow.value ?? ""
        let username = nameRow.value ?? ""
        let password = passwordRow.value ?? ""
        let email = emailRow.value ?? ""
        
        let user = User(name: name, username: username, email: email, password: password)
        
        NetworkManager.shared.signup(user: user) { success in
            DispatchQueue.main.async {
                switch success {
                case .success(let tokenResponse):
                    //                   print(tokenResponse.token)
                    
                    let registerVC = RegisterChildViewController()
                    //                    registerVC.token = tokenResponse.token
                    self.navigationController?.pushViewController(registerVC, animated: true)
                    
                case .failure(let error):
                    print(error)
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
