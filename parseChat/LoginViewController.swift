//
//  ViewController.swift
//  parseChat
//
//  Created by Gerard Recinto on 2/23/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

@MainActor
class LoginViewController: UIViewController {

    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    @IBAction func login(_ sender: Any) {
        do {
            try LocalChatService.shared.login(
                username: emailTextField.text ?? "",
                password: pwTextField.text ?? ""
            )
            performSegue(withIdentifier: "loginToNavigation", sender: self)
        } catch {
            let alert = UIAlertController(title: "Login Failed", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if LocalChatService.shared.isLoggedIn {
            performSegue(withIdentifier: "loginToNavigation", sender: self)
        }
    }
}

