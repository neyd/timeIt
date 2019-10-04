//
//  MiniTableViewController.swift
//  TimeIt
//
//  Created by Yevhen Neydel on 8/24/19.
//  Copyright © 2019 neydel. All rights reserved.
//

import UIKit

class MiniTableViewController: UITableViewController {
    var myEchoData: [MiniTask] = []
    var taskData: Task?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        setNewData(taskss: (taskData?.getAllMiniTasks())!)
    }
    
    func reloadDD(){
        tableView.reloadData()
    }

    func setNewData(taskss: [[String: Any]]) {
        var newData: [MiniTask] = []
        if let taskList =  taskss as? [[String: Any]] {
            for ii in taskList {
                let newTss = MiniTask(name: ii["miniName"] as! String, compl: (ii["didTask"] != nil))
                newData.append(newTss)
            }
            myEchoData = newData
        } else {
            myEchoData = []
        }
        
        reloadDD()
    }
    
    func getMiniTasksArr() -> [MiniTask] {
        return myEchoData
    }
    
    // MARK: - Table view data source

    // 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //
    //    // 2
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(myEchoData.count)
        return myEchoData.count
    }
    
    // 3
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MiniTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miniCell", for: indexPath)
        
        if let cell = cell as? MiniTableViewCell {
//            //            print(cell)
            cell.miniTaskOne = miniTasks[indexPath.row]
//            cell.miniTableViewCell = myEchoData[indexPath.row]
            print("cell")
        } else {
            print("No")
        }
        return (cell as? MiniTableViewCell)!
//        return cell as! MiniTableViewCell
    }

    // Override to support conditional editing of the table view.
//     override func tableView(setMiniTasksew: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
//        return true
//    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
