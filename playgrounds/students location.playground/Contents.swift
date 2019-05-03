import UIKit
import PlaygroundSupport

// this line tells the Playground to execute indefinitely
PlaygroundPage.current.needsIndefiniteExecution = true


struct Student : Codable{
    let createdAt :String
    let firstName :String
    let lastName  :String
    let latitude :Float
    let longitude :Float
    let mapString : String
    let mediaURL : String
    let objectId : String
    let uniqueKey : String?
    let updatedAt : String
}
struct Students : Codable {
    let results : [Student]
}
//Student locations************************
func getStudentsLocation(completion: @escaping (Bool, Error?) -> Void){
    var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
    request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
    request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            completion(false, error)
            print ("error in data")
            return
        }
        let response = try! JSONDecoder().decode(Students.self, from: data)
        print (response.results.first)
        //  print(String(data: response, encoding: .utf8))
    }
    task.resume()
}
