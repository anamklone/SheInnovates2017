/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var accountLabel: UILabel!
    
    var logInPosition = CGPoint()
    
    var signUpMode = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInPosition = CGPoint(x: logInButton.center.x, y: logInButton.center.y)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let testObject = PFObject(className: "TestObject2")
        
        testObject["foo"] = "bar"
        
        testObject.saveInBackground { (success, error) -> Void in
            
            // added test for success 11th July 2016
            
            if success {
                
                print("Object has been saved.")
                
            } else {
                
                if error != nil {
                    
                    print (error)
                    
                } else {
                    
                    print ("Error")
                }
                
            }
            
        }
        
    }

    @IBAction func logIn(_ sender: AnyObject) {
        
        if signUpMode {
            
            logInButton.center.x = signUpButton.center.x
            logInButton.center.y = signUpButton.center.y
            
            signUpButton.center.y = logInPosition.y
            
            //accountLabel.isHidden = true
            signUpMode = true
            
        } else {
            
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: { (user, error) in
                if error != nil {
                    let error = error as NSError?
                    
                    var errorMessage = "Log in failed"
                    
                    if let parseError = error?.userInfo["error"] as? String {
                        errorMessage = parseError
                    }
                    
                    self.createAlert(title: "Log In Error", message: errorMessage)
                    
                    print(errorMessage)
                    
                } else {
                    print("Logged in")
                }
            })
            
        }
    }
    
    @IBAction func signUp(_ sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        if signUpMode {
        
            if usernameField.text != "" || passwordField.text != "" {
            
                let user = PFUser()
            
                user.username = usernameField.text
                user.password = passwordField.text
            
                user.signUpInBackground( block: { (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                
                    
                    if error != nil {
                        
                        let error = error as NSError?
                    
                        var errorMessage = "Sign up failed"
                    
                        if let parseError = error?.userInfo["error"] as? String {
                            errorMessage = parseError
                        }
                        
                        self.createAlert(title: "Sign Up Error", message: errorMessage)
                        
                        print(errorMessage)
                        
                    } else {
                        print("Signed up")
                    }
 
                })
            } else {
                
                self.createAlert(title: "Error!", message: "Please enter a username and password")
            }
        } else {
            
            signUpButton.center.x = logInButton.center.x
            
            signUpButton.center.y = logInButton.center.y
            
            logInButton.center.x = logInPosition.x
            
            logInButton.center.y = logInPosition.y
            
            //accountLabel.isHidden = true
            
            signUpMode = false
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
