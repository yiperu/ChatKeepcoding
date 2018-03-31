//
//  LoginViewController.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 28/03/2018.
//  Copyright © 2018 ERISCO. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Attributes
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = UserInteractor.init(manager: UserDummy()).manager
        manager.isLogged(onSuccess: { (user) in
            self.navigateToDiscussions(user: user)
        }, onError: nil)
    }
    
    // MARK: - Navigation
    
    @IBAction func loginClicked(_ sender: Any) {
        
        guard let email = emailField.text else {
            return
        }
        
        guard let password = passwordField.text else{
            return
        }
        
        let user = User.init(id: "", email: email, password: password)
        
        let manager = UserInteractor.init(manager: UserDummy()).manager
        manager.login(user: user, onSuccess: { (user) in
            if user != nil {
                self.navigateToDiscussions(user: user)
            }
        }) { (error) in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
        guard let email = emailField.text else {
            return
        }
        
        guard let password = passwordField.text else{
            return
        }
        
        let user = User.init(id: "", email: email, password: password)
        
        let manager = UserInteractor.init(manager: UserDummy()).manager
        manager.register(user: user, onSuccess: { (user) in
            self.navigateToDiscussions(user: user)
        }) { (error) in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
    
    @IBAction func recoverClicked(_ sender: Any) {
        
        guard let email = emailField.text else {
            return
        }
        
        let user = User.init(id: "", email: email, password: nil)
        
        let manager = UserInteractor.init(manager: UserDummy()).manager
        manager.recoverPassword(user: user, onSuccess: { (user) in
            self.showAlert(title: "Password", message: "Password recovered")
        }) { (error) in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        
    }
    
    func navigateToDiscussions(user: User){
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DiscussionViewController") as? DiscussionViewController {
            if let navigator = navigationController {
                viewController.user = user
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
