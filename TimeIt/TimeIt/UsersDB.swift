//
//  UsersDB.swift
//  TimeIt
//
//  Created by Yevhen Neydel on 8/31/19.
//  Copyright © 2019 neydel. All rights reserved.
//

//import Foundation
import UIKit
//import Alamo

class UsersDB {
    //The login script url make sure to write the ip instead of localhost
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "http://time.it/main/"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    var userData: [String:Any]?
//    private var userList: [User] =
    var phpMyAdminArr: [[String: Any]] = [["authToken": "_khkj", "email": "asd@cio.com", "pass": "12345", "userData": ["firstName": "asdas", "lastName": "asdasd", "Email": "asd@cio.com"]],["authToken": "_Aasdaswew","email": "asd@cio.com" , "pass": "12345", "userData": ["firstName": "asdas", "lastName": "asdasd"]]]
    
    func findOne(privateKey: String, authToken: String = "", email: String = "") -> [String:Any] {
        var foundUser: [String:Any]?
        for php in self.phpMyAdminArr {
            if (php["authToken"] as? String == authToken || php["email"] as? String == email) && php["pass"] as? String == privateKey {
//                foundUser!["authToken"] = php["authToken"]
//                foundUser!["email"] = php["email"]
//                foundUser!["pass"] = php["pass"]
                
                if let foundedArr = php["userData"] as? [String:Any] {
//                    foundUser!["firstName"] = foundedArr!["firstName"]
//                    foundUser!["lastName"] = foundedArr!["lastName"]
                    let addDataArr = ["firstName": foundedArr["firstName"], "lastName": foundedArr["lastName"]] as? [String: Any]
                    foundUser = ["authTokem": php["authToken"], "email": php["email"], "pass": php["pass"], "userData": addDataArr]
                }
            } else {
                foundUser = ["Result": false]
                self.userData = foundUser
            }
        }
        self.userData = foundUser
        
        return self.userData!
    }
    
    func getOneFromDB(login: String, password: String) -> [String: Any] {
        
        return ["Error": true]
    }
    
    func loadUserData(token: String) {
    }
    
    private func saveData(withIndefiner: String) {
//        let defaults = UserDefaults.standard
//        //        defaults.removeObject(forKey: "OneTask")
//        var saveArr: [[String: Any]] = []
//        for user in userList {
//            saveArr.append(["userOne": user.getToken()])
//        }
//        defaults.set(saveArr, forKey: "userOneId")
//        defaults.synchronize()
    }
    
    func addNewUser(token: String = "", firstName: String, lastName: String, email: String, password: String) {
//        let newUser = User()
//        let hashNew = newUser.ndHashing(pass: password)
        let hashNew = password
        
        let newRowInArr: [String:Any] = ["authToken": token,"pass": hashNew,"email": email, "userData": ["firstName": firstName, "lastName": lastName]]
        
        /*Insert into DB*/
        phpMyAdminArr.append(newRowInArr)
    }
    
    func getUsers() -> [[String: Any]] {
        
        guard let url = URL(string: "https://neydel.com/8p23U7/taskIt/getAllUsers") else {return []}
        
        let session = URLSession.shared
        
        session.dataTask(with: url){ (data, responce, error) in
            if let responce = responce {
                print(responce)
            }
            
            guard let data = data else {return}
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                self.phpMyAdminArr = json as! [[String : Any]]
                //                let firstChild = try JSONSerialization.jsonObject(with: json, options: [])
                
                //                print(firstChild)
            } catch {
                print(error)
            }
        }.resume()
        return phpMyAdminArr
        /*Connect to DB and parse DATA*/
    }
    
    func preAuthApi(login: String, password: String) {
        
        guard let url = URL(string: "https://neydel.com/8p23U7/taskIt/getAuthetication") else {return}
        let parameter = ["lg": login, "pss": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameter, options: []) else {return}
        
        request.httpBody = httpBody
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, responce, error) in
            if let responce = responce {
                print(responce)
            }
            
            guard let data = data else {return}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
}
