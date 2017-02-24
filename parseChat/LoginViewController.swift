//
//  ViewController.swift
//  parseChat
//
//  Created by Gerard Recinto on 2/23/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var login: UIButton!
    
    @IBAction func login(_ sender: Any) {
     
        PFUser.logInWithUsername(inBackground: emailTextField.text!, password: pwTextField.text!) {  (user: PFUser?, error: Error?) -> Void in

            if ((user) != nil){
              self.performSegue(withIdentifier: "loginToNavigation", sender: self)
            } else {
                let alertController = UIAlertController(title: "Title", message: error?.localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)

                alertController.addAction(OKAction)
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
            }
            
    }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

