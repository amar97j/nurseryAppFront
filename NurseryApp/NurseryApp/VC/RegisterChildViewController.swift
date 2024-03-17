
import UIKit
import Eureka

class RegisterChildViewController: FormViewController {
    var token: String?
    var tokenResponse: TokenResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        token = UserDefaults.standard.string(forKey: "tokenAuth")
        
        self.tableView.backgroundColor = .white
        
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
        
        <<< TextRow() {
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
        let nameRow: TextRow? = form.rowBy(tag: tag.name.rawValue)
        let ageRow: TextRow? = form.rowBy(tag: tag.age.rawValue)
        let specialNeedRow: PickerInlineRow<String> = form.rowBy(tag: tag.specialNeed.rawValue) as! PickerInlineRow<String>
        
        guard let name = nameRow?.value, !name.isEmpty else {
            displayErrorMessage(message: "Please fill all the fields")
            return
        }
        
        guard let age = ageRow?.value, !age.isEmpty else {
            displayErrorMessage(message: "Please fill all the fields")
            return
        }
        
        let specialNeedName = specialNeedRow.value ?? "None"
        
       
        displaySuccessMessage()
    }
    
    func displayErrorMessage(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displaySuccessMessage() {
        let alertController = UIAlertController(title: "Success", message: "Registration Successful!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

enum tag: String {
    case name
    case age
    case specialNeed
}
