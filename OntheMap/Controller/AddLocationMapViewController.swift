//
//  AddLocationViewController.swift
//  OntheMap
//
//  Created by Sergio Costa on 01/07/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import MapKit

class AddLocationMapViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var studentLocation: StudentLocation? = nil
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        activityView.startAnimating()
        updateSearchResultsForSearchController(address: (studentLocation?.mapString)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResultsForSearchController(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let mark = MKPlacemark(placemark: placemark)
                
                if var region = self?.mapView?.region {
                    region.center = location.coordinate
                    region.span.longitudeDelta = 0.01
                    region.span.latitudeDelta = 0.01
                    self?.mapView.setRegion(region, animated: true)
                    self?.mapView.addAnnotation(mark)
                    
                    self?.studentLocation?.latitude = location.coordinate.latitude
                    self?.studentLocation?.longitude = location.coordinate.longitude
                }
            }
            DispatchQueue.main.async {
                self?.activityView.stopAnimating()
            }
        }
    }

    @IBAction func finish(_ sender: Any) {
        studentLocation?.uniqueKey = appDelegate.userSession?.account.key
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

