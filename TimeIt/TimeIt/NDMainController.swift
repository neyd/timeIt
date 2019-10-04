//
//  NDViewController.swift
//  TimeIt
//
//  Created by Yevhen Neydel on 8/31/19.
//  Copyright © 2019 neydel. All rights reserved.
//

import UIKit

class NDMainController: UIViewController {
    var myData: User = User()
    var usersLocal: [[String: Any]] = []
    var usersNd = UsersDB()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is SignUpViewController
        {
            let vc = segue.destination as? SignUpViewController
            vc?.userNdDB = usersNd
            vc?.userLocalData = usersLocal
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuth()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var inEmail: UITextField!
    @IBOutlet weak var inPass: UITextField!
    
    @IBAction func signInBtn(_ sender: Any) {
        let inEmailField = inEmail.text
        let inPassField = inPass.text
        usersNd.preAuthApi(login: "jj.nd", password: "11")
//        signInNow(email: inEmailField!, pass: inPassField!)
    }
    
    func signInNow(token:String = "", email: String, pass: String) {
//        let newUser = self.usersNd.findOne(privateKey: pass, authToken: "", email: email)
        let newUser = User(email: email, password: pass)
        
        if newUser.isAuthenticated() {
            myData = newUser
            performSegue(withIdentifier: "endAuth", sender: self)
        } else {
            initializeError()
            print("Bad")
        }
        
    }
    
    @IBAction func openSignIn(segue:UIStoryboardSegue) {
        let taskDetailVC = segue.source as! SignUpViewController
        
        self.usersNd = taskDetailVC.userNdDB
        self.usersLocal = self.usersNd.getUsers()
    }
    
    func checkAuth(){
        if !myData.isAuthenticated(){
            print("Should to login")
        } else {
            print("Authorized")
            performSegue(withIdentifier: "endAuth", sender: self)
        }
    }
    
    
    private func initializeError(){
        inEmail.backgroundColor = UIColor(named: "ndWarning")
        inPass.backgroundColor = UIColor(named: "ndWarning")
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
