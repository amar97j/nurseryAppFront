//
//  RegisterChildViewController.swift
//  NurseryApp
//
//  Created by Abdullah Bin Essa on 3/11/24.
//

import UIKit
import Eureka

class RegisterChildViewController: FormViewController {
    var token: String?
    
    private var blurView: UIVisualEffectView!
    private var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .white
        setupBackgroundImage()
        setupBlurBackground()
        
        form +++ Section("Child Information")
        <<< TextRow() {
            $0.title = "Name"
            $0.placeholder = "Enter your child's name"
            $0.tag = tag.name.rawValue
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChange
            $0.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< IntRow() {
            $0.title = "Age"
            $0.placeholder = "Enter your child's age"
            $0.tag = tag.age.rawValue
            $0.add(rule: RuleRequired())
            $0.validationOptions = .validatesOnChange
            $0.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        
        +++ Section("Special Needs")
        <<< PickerInlineRow<String>() {
            $0.title = "Select Special Needs"
            $0.tag = tag.specialNeed.rawValue
            $0.options = ["None", "Regular", "ADHD", "Learning Difficulties", "Bilingual"]
            $0.value = "None"
        }
        
        +++ Section()
        <<< ButtonRow() {
            $0.title = "Register"
            $0.onCellSelection { _, _ in
                self.registerButtonTapped()
            }
            $0.cellSetup { cell, row in
                cell.backgroundColor = .systemGreen
            }
            $0.cellUpdate { cell, row in
                cell.textLabel?.textColor = .white
            }
        }
    }
    
    func registerButtonTapped() {
        let errors = form.validate()
        
        guard errors.isEmpty else{
            print(errors)
            return
        }
        
        let nameRow: TextRow? = form.rowBy(tag: tag.name.rawValue)
        let ageRow: TextRow? = form.rowBy(tag: tag.age.rawValue)
        let specialNeedRow: PickerInlineRow<String> = form.rowBy(tag: tag.specialNeed.rawValue) as! PickerInlineRow<String>
        
        let name = nameRow?.value ?? ""
        let age = ageRow?.value ?? "" // need to convert to string
        let specialNeedName = specialNeedRow.value ?? "None"
        
        let specialNeedId: Int
        switch specialNeedName {
        case "None":
            specialNeedId = 0 // Set the ID for "None"
        case "Regular":
            specialNeedId = 1 // Set the ID for "Regular"
        case "ADHD":
            specialNeedId = 2 // Set the ID for "ADHD"
        case "Learning Difficulties":
            specialNeedId = 3 // Set the ID for "Learning Difficulties"
        case "Bilingual":
            specialNeedId = 4 // Set the ID for "Bilingual"
        default:
            specialNeedId = 0 // Set default ID if the special need is not recognized
        }
        
        let specialNeedCase = ChildCaseId(id: specialNeedId, name: specialNeedName)
        
        let child = Child(name: name, age: age, caseId: [specialNeedCase])
        
        NetworkManager.shared.registerChild(child: child) { success in
            
            // Handling Network Request
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    // Handle submission error, e.g., show an error alert
                }
            }
            
        }
        print("Register button tapped")
    }
    
    private func setupBackgroundImage() {
        imageView = UIImageView(image: UIImage(named: "nursery"))
        imageView.frame = view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }
    
    private func setupBlurBackground() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurView, belowSubview: imageView) 
    }
    
    enum tag: String{
        case name
        case age
        case specialNeed
    }
}
