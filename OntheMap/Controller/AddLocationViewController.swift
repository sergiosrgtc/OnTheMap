//
//  AddLocationViewController.swift
//  OntheMap
//
//  Created by Sergio Costa on 01/07/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var website: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Hide Keyboard after tap is done
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        if firstName.text != "" && lastName.text != "" && address.text != "" && website.text != "" {
            self.performSegue(withIdentifier: "showAddMapVC", sender: nil)
        }else{
            self.showAlert("Warning", message: "Please fill in all the fields")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addlocationMapVC = segue.destination as? AddLocationMapViewController {
            var studentLocation = StudentLocation()
            studentLocation.firstName = firstName.text!
            studentLocation.lastName = lastName.text!
            studentLocation.mapString = address.text!
            studentLocation.mediaURL = website.text!
            
            addlocationMapVC.studentLocation = studentLocation
        }
    }
}

