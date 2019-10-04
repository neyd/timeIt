//
//  Users.swift
//  TimeIt
//
//  Created by Yevhen Neydel on 8/31/19.
//  Copyright © 2019 neydel. All rights reserved.
//

import Foundation
import CommonCrypto

class User {
    private var _auth: Bool = false
    private var _authToken: String = ""
    private var _firstName: String = ""
    private var _lastName: String = ""
    private var _email: String = ""
    
    init(token: String = "", email: String = "", password: String = "") {
        if token == "" && email == "" {
            return
        }
        self._authToken = token
        self._email = email
        verify(passwordStr: password)
    }
    
    func isAuthenticated() -> Bool {
        return self._auth
    }
    
    func getMe() -> User {
        return self
    }
    
    func getName() -> String {
        return self._firstName+self._lastName
    }
    func getEmail() -> String {
        return self._email
    }
    
    func ndHashing(pass: String) -> String {
        do {
            let sourceData = "AES256".data(using: .utf8)!
            let password = pass
//            AES256Crypter.randomData(length: 32)
            let salt = AES256Crypter.randomSalt()
            let iv = AES256Crypter.randomIv()
            let key = try AES256Crypter.createKey(password: password.data(using: .utf8)!, salt: salt)
            let aes = try AES256Crypter(key: key, iv: iv)
            let encryptedData = try aes.encrypt(sourceData)
//            let encryptedData = "try aes.encrypt(sourceData)"
            
//            return "encryptedData"
            return "\(encryptedData)"
        } catch {
            return "Error"
        }
        
    }
    
    func verify(passwordStr: String) -> User {
//        if ndHashing(pass: passwordStr) == "Error"{
//            return User();
//        } else {
            let db = UsersDB()
            let user = db.findOne(privateKey: passwordStr, authToken: self._authToken, email: self._email)
            if user["Result"] as? Bool == false {
                return User()
            } else {
                print(user)
                return self
                self._firstName = user["firstName"] as! String
                self._lastName = user["lastName"] as! String
                self._email = user["Email"] as! String
                self._auth = true
                return self
            }
//        }
    }
    
    
    func getToken() -> String {
        return self._authToken
    }
    
}
