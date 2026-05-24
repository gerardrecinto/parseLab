//
//  SignUpViewController.swift
//  parseChat
//
//  Created by Gerard Recinto on 2/23/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

@MainActor
class SignUpViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func submit(_ sender: Any) {
        do {
            try LocalChatService.shared.signup(
                username: email.text ?? "",
                password: password.text ?? ""
            )
            performSegue(withIdentifier: "loginToNavigation", sender: self)
        } catch {
            let alert = UIAlertController(title: "Sign Up Failed", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
