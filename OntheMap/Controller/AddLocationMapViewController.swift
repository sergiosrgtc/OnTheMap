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
    var activityView : UIActivityIndicatorView?
    var studentLocation: StudentLocation? = nil
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activityView = configureActivityIndicator()
        activityView?.startAnimating()
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
            }else{
                self?.showAlert("Warning", message: "Address not found!")
                self?.navigationController?.popViewController(animated: true)
            }
            DispatchQueue.main.async {
                self?.activityView?.stopAnimating()
            }
        }
    }

    @IBAction func finish(_ sender: Any) {
        activityView?.startAnimating()
        view.alpha = 0.5
        studentLocation?.uniqueKey = appDelegate.userSession?.account.key
        
        UdacityClient.sharedInstance.postStudentLocation(studentLocation: studentLocation!) { (result, error) in
            if error == nil{
                print("Worked")
                self.dismiss(animated: true, completion: nil)
            }else{
                self.showAlert("Error", message: error!.userInfo[NSLocalizedDescriptionKey] as! String)
            }
            DispatchQueue.main.async {
                self.activityView?.stopAnimating()
                self.view.alpha = 1.0
            }
        }
    }
}

