//
//  usersTableViewController.swift
//  On-The-Map
//
//  Created by Eslam  on 4/11/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import UIKit

class usersTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        parseClient.getStudentsLocation(completion: handleResponse(students:error:))
                
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func refresh () {
        
        parseClient.getStudentsLocation(completion: handleResponse(students:error:))
    }
    


    @IBAction func logout (){

        UdacityClient.logout {
            DispatchQueue.main.async {
                let loginVc = self.storyboard!.instantiateViewController(withIdentifier: "loginViewController") as? loginViewController
                self.present(loginVc!, animated: true, completion: nil)            }
        }
    }


func handleResponse(students: [student], error: Error?) {
    
        if error != nil{
            raiseAlertView(withTitle: "failure", withMessage: error! .localizedDescription)
            } else {
            studentsModel.students = students
            self.tableView.reloadData()
        }
    }
}
extension usersTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsModel.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentTableViewCell")!
        
        let student = studentsModel.students[indexPath.row]
        
        let studentFirstName = student.firstName
        let studentLastName = student.lastName
        let studentLink = student.mediaURL
        
        var nameLabel: String {
            var name = ""
            if let studentFirstName = studentFirstName {
                name = studentFirstName
            }
            if let studentLastName = studentLastName {
                if name.isEmpty {
                    name = studentLastName
                } else {
                    name += " \(studentLastName)"
                }
            }
            if name.isEmpty {
                name = "*No name provided*"
            }
            return name
        }
    
        cell.textLabel?.text = nameLabel
        
        if let studentLink = studentLink{
        cell.detailTextLabel?.text = studentLink
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // var selectedIndex = indexPath.row
        let student = studentsModel.students[indexPath.row]
        let studentLink = student.mediaURL
        guard let studentLinkk = studentLink else {
            return
        }
        guard studentLinkk != "" else{
            return
        }
            let app = UIApplication.shared
            app.openURL(URL(string: studentLinkk)!)
            /*let webScreen = self.storyboard!.instantiateViewController(withIdentifier: "webViewController") as! webViewController
            webScreen.destination = studentLink
            navigationController?.pushViewController(webScreen, animated: true)*/
    }

}

