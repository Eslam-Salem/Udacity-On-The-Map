//
//  addLocationViewController.swift
//  On-The-Map
//
//  Created by Eslam  on 4/16/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import UIKit
import CoreLocation

class addLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func findLocation (){
        
        setFindingLocation(true)
        if locationTextField.text == ""{
            raiseAlertView(withTitle: "Adding failure", withMessage: "Please enter your location!")
        }
        
        guard let studentAdress = locationTextField.text else {return}
        
        if let studentUrl = urlTextField.text {
            newStudentInfo.mediaURL = studentUrl
        }
        
        self.geocoder(address: studentAdress, completion: handleResponse(success:error:))
    }

    @IBAction func cancel (){
       
        dismiss(animated: true, completion: nil)
    }
    
    
    func handleResponse (success: Bool, error: Error?) {
        
        setFindingLocation(false)
        if success{
            let locationVc = self.storyboard!.instantiateViewController(withIdentifier: "finishAddLocationViewController") as! finishAddLocationViewController
            locationVc.studentAddress = locationTextField.text!
            self.present(locationVc, animated: true, completion: nil)

        } else {
            raiseAlertView(withTitle: "Adding failure", withMessage: "No Location like that!!")
        }
    }
    
    func setFindingLocation(_ finding: Bool) {
        
        if finding {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    
    func geocoder (address : String , completion: @escaping (Bool, Error?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            if error != nil {
                completion(false,error)
            }
            else {
                newStudentInfo.latitude = lat!
                newStudentInfo.longitude = lon!
                newStudentInfo.mapString = address
                completion(true,nil)
            }
        }
    }
    
}
