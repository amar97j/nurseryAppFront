import UIKit

class MainTabBarController: UITabBarController {

    
    var token: String?
    var user: User?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        customizeTabBar()
        token = UserDefaults.standard.string(forKey: "tokenAuth")

    }

    func setupViewControllers() {
        let firstViewController = NurseryViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Nurseries", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        let secondViewController = RegisterChildViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Register", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let ThirdViewController = EnrollmentViewController()
        ThirdViewController.tabBarItem = UITabBarItem(title: "Enrollment", image: UIImage(systemName: "envelope"), selectedImage: UIImage(systemName: "envelope.fill"))

        viewControllers = [firstViewController, secondViewController,ThirdViewController]
    }
    
    
    func customizeTabBar(){
        tabBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.tintColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        tabBar.layer.cornerRadius = 10
        tabBar.barTintColor = .white
    }
    
    func callNursery(){
        
        let nurseryVC = NurseryViewController()
        
        nurseryVC.token = token
        
        self.navigationController?.pushViewController(nurseryVC, animated: true)
    }
        
        
        
    }

   

