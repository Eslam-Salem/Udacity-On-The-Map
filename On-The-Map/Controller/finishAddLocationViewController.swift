//
//  addLocationViewController.swift
//  On-The-Map
//
//  Created by Eslam  on 4/15/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

//import UIKit
import CoreLocation
import MapKit

class finishAddLocationViewController: UIViewController {
   
    @IBOutlet weak var mapView: MKMapView!

    var studentAddress : String = ""
    var initalLocation : CLLocation!
    let regionRadius: CLLocationDistance = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLatAndLon(address: studentAddress)
    }
    
    
    @IBAction func cancel (){
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func finish (){
        
        parseClient.addLocation(firstName: newStudentInfo.firstName, lastName: newStudentInfo.lastName ,mapString: newStudentInfo.mapString, mediaUrl: newStudentInfo.mediaURL, latitude: newStudentInfo.latitude , longitude: newStudentInfo.longitude, completion: handleAddingResponse(success:error:))
    }
    
    func handleAddingResponse(success: Bool, error: Error?) {
        if success{
            if let tabViewController = storyboard!.instantiateViewController(withIdentifier: "tabBarViewController") as? tabBarViewController {
                present(tabViewController, animated: true, completion: nil)
            }
        } else {
            raiseAlertView(withTitle: "Adding Faliure", withMessage: "Posting Failed!!")
        }
    }

     public func getLatAndLon (address : String)  {
     
        self.initalLocation = CLLocation(latitude: newStudentInfo.latitude, longitude: newStudentInfo.longitude)
        self.centerMapOnLocation(location: self.initalLocation)
        let coordinate = CLLocationCoordinate2D(latitude: newStudentInfo.latitude, longitude: newStudentInfo.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = address
        self.mapView.addAnnotation(annotation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
