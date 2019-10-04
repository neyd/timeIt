//
//  TaskListViewController.swift
//  NeydelApp
//
//  Created by Yevhen Neydel on 8/16/19.
//  Copyright © 2019 neydel. All rights reserved.
//

import UIKit

class TaskListViewController: UITableViewController {
    
    var timer: Timer?
    var tasks : [Task] = []
    var newCar: String = ""
    var allCells: [TaskTableViewCell] = []
    var cashCells: [TaskTableViewCell] = []
    var newNewCells: [TaskTableViewCell] = []
    @IBOutlet weak var startCellBtn: UILabel!
    @IBOutlet weak var addTaskBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskBtn.frame.size.width = addTaskBtn.frame.size.height
        addTaskBtn.layer.cornerRadius = addTaskBtn.frame.size.width / 2
        loadUserData()
//        createTimer()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is OneTaskViewController
        {
            let vc = segue.destination as? OneTaskViewController
            let myCell = checkMyCell()
            vc?.oneTask = myCell?.task
            vc?.savedTasks = tasks
        }
    }
    
    func checkMyCell() -> TaskTableViewCell? {
        cashCells = []
        var myCurrCell: TaskTableViewCell = TaskTableViewCell()
        for cells in allCells {
            if cells.isSel() {
                myCurrCell = cells
            } else {
                cashCells.append(cells)
            }
        }
        return myCurrCell
    }
    @IBAction func start(segue:UIStoryboardSegue) {
        if segue.identifier == "startSegueBack" {
            newNewCells = []
            clearAllCells()
            saveUserData()
            tableView.reloadData()
        }
    }
    
    func clearAllCells() {
        for cell in allCells {
            cell.mySelected = false
        }
        allCells = []
    }
    
    func saveUserData(){
        let defaults = UserDefaults.standard
//        defaults.removeObject(forKey: "OneTask")
        var saveArr: [[String: Any]] = []
        for task in tasks {
            saveArr.append(task.getMe())
        }
        defaults.set(saveArr, forKey: "oneTaskId")
        defaults.synchronize()
    }
    func loadUserData(){
        if let arr = UserDefaults.standard.array(forKey: "oneTaskId") as? [[String: Any]] {
            for task in arr {
                let newTsk: Task = Task(name: task["Name"] as! String)
                newTsk.initSaved(creation: task["Creation"] as! Date, complete: task["Completed"] as! Bool,time: task["myTime"] as! Int)
                if let arr =  task["miniTasks"] as? [[String:Any]]{
                    var updMiniList: [MiniTask] = []
                    for itt in arr {
                        let nImI = MiniTask(name: itt["miniName"] as! String, compl: ((itt["didTask"] as? Bool)!))
//                        let didSel = itt["didTask"] as? Bool
//                        if didSel! == true {
//                            nImI.setSelection(compl: true)
//                        } else {
//                            nImI.setSelection(compl: false)
//                        }
                        updMiniList.append(nImI)
                    }
                    newTsk.updateSubTasks(subTasks: updMiniList)
                }
                tasks.append(newTsk)
            }
//            tasks.append(newTsk)
        } else {
            tasks = []
        }
    }
    
    func addTask(taskName: String) {
        allCells = []
        var disableAdding: Bool = false;
        let trimmedName = taskName.trimmingCharacters(in: .whitespacesAndNewlines)
        for tsk in tasks {
            if tsk.getName() == trimmedName {
                disableAdding = true
            }
        }
        if disableAdding {
            return
        }
        let taskNew: Task = Task(name: trimmedName)
        tasks.append(taskNew)
        saveUserData()
        tableView.reloadData()
    }
    
    func removeTask(at index: Int) {
        tasks.remove(at: index)
        saveUserData()
        tableView.reloadData()
    }
    
//    func createTimer(at index: Int) {
//
//    }
    
//    // 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//
//    // 2
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // 3
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TaskTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        if let cell = cell as? TaskTableViewCell {
            if (tasks[indexPath.row].getComplited() as? Bool) == true {
                cell.backgroundColor = UIColor(named: "ndWarning")
            } else {
                cell.backgroundColor = .none
            }
            
            cell.task = tasks[indexPath.row]
            allCells.append(cell)
        }
        return cell as! TaskTableViewCell
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        let taskDetailVC = segue.source as! TasksDetailViewController
        if taskDetailVC.name != ""{
            addTask(taskName: taskDetailVC.name)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for ttsk in tasks {
            ttsk.deSelectThis()
        }
        tasks[indexPath.row].selectThis()
        performSegue(withIdentifier: "startSegueModal", sender: self)
    }
    
//    func findSelectedCell() -> Int {
//        for i in 0...tasks.count {
//            tableView.ind(at: i)
//        }
//    }
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let desc = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        print(desc)
        return cell
    }*/
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 
    
    
    
 
//    Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            Delete; the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
            let rowNum : Int = indexPath.row
            removeTask(at: rowNum)
            
            
//            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            //             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            print("editing")
            
            
        }
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let
//    }
    
    
    
     
    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
    

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

// MARK: - Timer
//extension TaskListViewController {
//    @objc func updateTimer() {
//        // 1
//        guard let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows else {
//            return
//        }
//
//        for indexPath in visibleRowsIndexPaths {
//            // 2
//            if let cell = tableView.cellForRow(at: indexPath) as? TaskTableViewCell {
////                if cell.isSel() {
////                    cell.timeLabel.text = tasks.last?.getTime()
//////                    cell.checkTime(cellRow: tasks.last!)
////                    cell.mySelected = false;
////                    updateTimer()
////                } else {
////                    print("What A Fuck")
////                }
//            }
//        }
//    }
//
//    func createTimer() {
//        // 1
//        if timer == nil {
//            // 2
//            timer = Timer.scheduledTimer(timeInterval: 1.0,
//                                         target: self,
//                                         selector: #selector(updateTimer),
//                                         userInfo: nil,
//                                         repeats: true)
//        }
//    }
//}
