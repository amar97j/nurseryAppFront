//
//  RegisterChildViewController.swift
//  NurseryApp
//
//  Created by Abdullah Bin Essa on 3/11/24.
//

import UIKit
import Eureka

class RegisterChildViewController: FormViewController {
    
    private var blurView: UIVisualEffectView!
    private var imageView: UIImageView!

    
    override func viewDidLoad() {
        setupBackgroundImage()
        setupBlurBackground()
        super.viewDidLoad()
        
        
        form +++ Section("Child Information")
            <<< TextRow() {
                $0.title = "Name"
                $0.placeholder = "Enter your child's name"
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
            <<< TextRow() {
                $0.title = "Nationality"
                $0.placeholder = "Enter your child's nationality"
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
                $0.options = ["None", "Autism", "Dyslexia", "ADHD", "Down Syndrome"]
                $0.value = "None"
            }
        
        +++ Section("Location")
            <<< PickerInlineRow<String>() {
                $0.title = "Select Governorate"
                $0.options = ["Al Ahmadi", "Al Farwaniyah", "Al Asimah", "Hawalli", "Mubarak Al-Kabeer", "Jahra"]
                $0.value = "Al Ahmadi"
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
        // we have to handle it
        print("Register button tapped")
    }
    
    private func setupBackgroundImage() {
        imageView = UIImageView(image: UIImage(named: "nursery")) // Replace "backgroundImage" with the name of your image file
        imageView.contentMode = .scaleAspectFill
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
        view.insertSubview(blurView, belowSubview: imageView) // Add blur view below background image view
    }
}
