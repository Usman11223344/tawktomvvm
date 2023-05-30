import Foundation
import UIKit


extension UIViewController {
    
    enum Storyboard: String {
        case main = "Main"
        
        var instance: UIStoryboard {
            return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        }
        
        func viewController<T : UIViewController>(Class _viewControllerClass: T.Type) -> T {
            let  storboardID = (_viewControllerClass as UIViewController.Type).storyboardID
            return self.instance.instantiateViewController(withIdentifier: storboardID) as! T
        }
    }
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func initiateFrom(Storybaord _storybaord: Storyboard) -> Self {
        return _storybaord.viewController(Class: self)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    
}

