//
//  TasksDetailViewController.swift
//  NeydelApp
//
//  Created by Yevhen Neydel on 8/16/19.
//  Copyright © 2019 neydel. All rights reserved.
//

import UIKit

class TasksDetailViewController: UIViewController {
    
    var name: String = ""
    
    @IBOutlet weak var taskName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            name = taskName.text!
        } else {
            name = ""
        }
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
