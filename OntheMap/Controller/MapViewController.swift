//
//  MapViewController
//  OntheMap
//
//  Created by Sergio Costa on 28/06/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import UIKit
import MapKit

/**
 * This view controller demonstrates the objects involved in displaying pins on a map.
 *
 * The map is a MKMapView.
 * The pins are represented by MKPointAnnotation instances.
 *
 * The view controller conforms to the MKMapViewDelegate so that it can receive a method
 * invocation when a pin annotation is tapped. It accomplishes this using two delegate
 * methods: one to put a small "info" button on the right side of each pin, and one to
 * respond when the "info" button is tapped.
 */

class MapViewController: UIViewController, MKMapViewDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var activityView : UIActivityIndicatorView?

    // The map. See the setup in the Storyboard file. Note particularly that the view controller
    // is set up as the map view's delegate.
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getStudentLocations()
    }
    
    func getStudentLocations(){
        activityView = configureActivityIndicator()
        activityView?.startAnimating()
        view.alpha = 0.5
        UdacityClient.sharedInstance.getStudentLocations({ (studentLocation, error) in
            if error == nil {
                if let downloadedStudentLocations = studentLocation{
                    self.appDelegate.studentLocations = downloadedStudentLocations
                    self.insertStudentLocationInMapView(self.appDelegate.studentLocations!)
                }
            } else {
                self.showAlert("Error", message: error!.userInfo[NSLocalizedDescriptionKey] as! String)
            }
            DispatchQueue.main.async {
                self.activityView?.stopAnimating()
                self.view.alpha = 1.0
            }
        })
    }
    
    func insertStudentLocationInMapView(_ studentLocations: StudentLocations) {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
        // We will create an MKPointAnnotation for each dictionary in "locations". The
        // point annotations will be stored in this array, and then provided to the map view.
        var annotations = [MKPointAnnotation]()
        
        // The "locations" array is loaded with the sample data below. We are using the dictionaries
        // to create map annotations. This would be more stylish if the dictionaries were being
        // used to create custom structs. Perhaps StudentLocation structs.
        
        for location in studentLocations.studentLocations {
            var coordinate : CLLocationCoordinate2D? = nil
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            if let lat = location.latitude{
                if let long = location.longitude{
                    // The lat and long are used to create a CLLocationCoordinates2D instance.
                    coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
                }
            }
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            if let coord = coordinate{
                annotation.coordinate = coord
            }
            if let first = location.firstName{
                annotation.title = first
            }
            if let last = location.lastName{
                annotation.title?.append(" \(last)")
            }
            if let mediaURL = location.mediaURL{
                annotation.subtitle = mediaURL
            }
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        
        // When the array is complete, we add the annotations to the map.
        DispatchQueue.main.async {
            self.mapView.addAnnotations(annotations)
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        getStudentLocations()
    }
    
    @IBAction func logOut(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = #colorLiteral(red: 0.1321616769, green: 0.6392914653, blue: 0.8661773801, alpha: 1)
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: ["": ""], completionHandler: nil)
            }
        }
    }   
}

