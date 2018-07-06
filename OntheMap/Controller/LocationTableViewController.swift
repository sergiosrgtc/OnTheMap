//
//  SecondViewController.swift
//  OntheMap
//
//  Created by Sergio Costa on 28/06/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit

class LocationTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.studentLocations?.studentLocations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
        let userLocation = appDelegate.studentLocations?.studentLocations[indexPath.row]
        
        cell?.imageView?.image = UIImage.init(named: "baseline_person_pin_circle_black_36pt")
        
        if let fistName = userLocation?.firstName{
            cell?.textLabel?.text = fistName
        }else{
            cell?.textLabel?.text? = "[No First Name]"
        }
        if let lastName = userLocation?.lastName{
            cell?.textLabel?.text?.append(" \(lastName)")
        }else{
            cell?.textLabel?.text?.append(" [No Last Name]")
        }
        if let mediaUrl = userLocation?.mediaURL{
            cell?.detailTextLabel?.text = mediaUrl
        }else{
            cell?.detailTextLabel?.text = "[No Media URL]"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userLocation = appDelegate.studentLocations?.studentLocations[indexPath.row]
        let app = UIApplication.shared
        if let toOpen = userLocation?.mediaURL {
            app.open(URL(string: toOpen)!, options: ["": ""], completionHandler: nil)
        }
    }
}

