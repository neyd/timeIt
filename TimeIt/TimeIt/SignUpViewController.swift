//
//  SignUpViewContainerViewController.swift
//  TimeIt
//
//  Created by Yevhen Neydel on 8/31/19.
//  Copyright © 2019 neydel. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var upFirstName: UITextField!
    @IBOutlet weak var upLastName: UITextField!
    @IBOutlet weak var upEmail: UITextField!
    @IBOutlet weak var upPassword: UITextField!
    @IBOutlet weak var upCheckPassword: UITextField!
    @IBOutlet weak var upAgreement: UISwitch!
    
    var userLocalData: [[String: Any]] = []
    var userNdDB = UsersDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLocalData = userNdDB.getUsers()
        // Do any additional setup after loading the view.
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        print(textField)
        if textField == upFirstName {
            textField.resignFirstResponder()
            upLastName.becomeFirstResponder()
        } else if textField == upLastName {
            textField.resignFirstResponder()
            upEmail.becomeFirstResponder()
        } else if textField == upEmail {
            textField.resignFirstResponder()
            upPassword.becomeFirstResponder()
        } else if textField == upPassword {
            textField.resignFirstResponder()
            upCheckPassword.becomeFirstResponder()
        } else if textField == upCheckPassword {
            textField.resignFirstResponder()
        }
        return true
        // Do not add a line break
//        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc = segue.destination as? NDMainController
        print(userNdDB)
        print(userNdDB.getUsers())
        vc?.usersNd = self.userNdDB
        vc?.usersLocal = self.userLocalData
    }

    @IBAction func signUp(_ sender: Any) {
        let passwordVal = upPassword.text
        let checkPass = upCheckPassword.text
        
        if passwordVal != checkPass {
            upCheckPassword.backgroundColor = UIColor(named: "ndWarning")
            print("Do not match")
            return
        }
        
        let firstNameVal: String = upFirstName.text!
        let lastNameVal: String = upLastName.text!
        let emailVal: String = upEmail.text!
        if upAgreement.isOn == false {
            upAgreement.thumbTintColor = UIColor(named: "ndWarning")
            return
        }
        
        self.userNdDB.addNewUser(firstName: firstNameVal, lastName: lastNameVal, email: emailVal, password: passwordVal!)
        
        self.userLocalData = userNdDB.getUsers()
        
        performSegue(withIdentifier: "showSignIn", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
