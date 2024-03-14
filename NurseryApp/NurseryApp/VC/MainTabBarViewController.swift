import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
           super.viewDidLoad()
           setupViewControllers()
       }

       func setupViewControllers() {
           let nurseryViewController = NurseryViewController()
           nurseryViewController.tabBarItem = UITabBarItem(title: "Nurseries", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
           
           let registerChildViewController = RegisterChildViewController()
           registerChildViewController.tabBarItem = UITabBarItem(title: "Register Child", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))

           let viewControllers = [nurseryViewController, registerChildViewController]
           self.viewControllers = viewControllers.map { UINavigationController(rootViewController: $0) }
       }
   }
