//
//  SignUpViewController.swift
//  parseChat
//
//  Created by Gerard Recinto on 2/23/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit
import Parse
class SignUpViewController: UIViewController {
    @IBOutlet weak var email: UITextField!

    @IBOutlet weak var password: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        myMethod()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func myMethod() {
        var user = PFUser()
        user.username = email.text
        user.password = password.text
        user.email = email.text
        // other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                print("Sign up error")
                let errorString = error.localizedDescription
                // Show the errorString somewhere and let the user try again.
            } else {
                print("Sign up success!")
                // Hooray! Let them use the app now.
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
