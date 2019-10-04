//
//  MiniTableViewCell.swift
//  TimeIt
//
//  Created by Yevhen Neydel on 8/24/19.
//  Copyright © 2019 neydel. All rights reserved.
//

import UIKit

class MiniTableViewCell: UITableViewCell {
    @IBOutlet weak var miniNameLabel: UILabel!
//    @IBOutlet weak var miniDidStatus: UISwitch!
    var miniName: String = ""
    var didTask: Bool = false
    
    var miniTaskOne: MiniTask? {
        didSet{
            self.miniName = (self.miniTaskOne?.getName())!
            self.didTask = ((self.miniTaskOne?.getSelection()) != nil)
            miniNameLabel.text = self.miniTaskOne?.getName()
            getStatus()
            
        }
    }
    
    func getStatus(){
//        miniDidStatus.isOn = (self.miniTasks?.getComplited() != nil)
    }
    func changeStatus(){
//        var st = miniDidStatus.isOn
//        if st {
//            st = false
//        } else {
//            st = true
//        }
//    self.miniTasks?.setComplited(compl: st)
    }
    @IBAction func changeStatus(_ sender: Any) {
        changeStatus()
    }
    //    var miniTask: MiniTableViewCell? {
//        didSet {
//            miniNameLabel.text = miniName
//        }
//    }
    
//    func addMini(miniNameSet: String, complited: Bool){
//        self.miniName = miniNameSet
//        self.didTask = complited
//        print("miniNameSet")
//    }
}
