//
//  usersMapViewController.swift
//  On-The-Map
//
//  Created by Eslam  on 4/14/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import UIKit
import MapKit

class usersMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getStudentsAnnotations()
    }
    

    @IBAction func refresh () {
        parseClient.getStudentsLocation { student, error in
            studentsModel.students = student
            
                self.getStudentsAnnotations()
                self.mapView.reloadInputViews()
            
        }
    }
    
    
    @IBAction func logout (){
        UdacityClient.logout {
            DispatchQueue.main.async {
                let loginVc = self.storyboard!.instantiateViewController(withIdentifier: "loginViewController") as? loginViewController
                self.present(loginVc!, animated: true, completion: nil)
            }
        }
    }
    
    
    func getStudentsAnnotations () {

        let students = studentsModel.students
        
        var annotations = [MKPointAnnotation]()
        
        for student in students {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            let lat = CLLocationDegrees(student.latitude ?? 0.0)
            let long = CLLocationDegrees(student.longitude ?? 0.0)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = student.firstName ?? ""
            let last = student.lastName ?? ""
            let mediaURL = student.mediaURL
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
        }
        // When the array is complete, we add the annotations to the map.
        self.mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
    
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
}
