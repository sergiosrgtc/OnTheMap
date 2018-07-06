//
//  LogInViewController.swift
//  OntheMap
//
//  Created by Sergio Costa on 03/07/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logIn(_ sender: Any) {
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        activityView.startAnimating()
        
        if email.text != ""  && password.text != ""{
            UdacityClient.sharedInstance().postSessionLogin(email: email.text! , password: password.text!, completionHandlerForPostSession: { (userSession, error) in
                if error == nil && userSession != nil{
                    if userSession!.account.registered{
                        self.appDelegate.userSession = userSession
                        self.performSegue(withIdentifier: "login", sender: nil)
                    }else{
                        self.showAlert("Error", message: "User not registered")
                    }
                }else{
                    self.showAlert("Error", message: error!.userInfo[NSLocalizedDescriptionKey] as! String)
                }
                DispatchQueue.main.async {
                    self.activityView.stopAnimating()
                }
            })
        }else{
            showAlert("Warning", message: "Please fill both fields!")
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        let app = UIApplication.shared
        app.open(URL(string: "https://auth.udacity.com/sign-up")!, options: ["": ""], completionHandler: nil)
    }
}
