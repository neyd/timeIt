//
//  OneTaskViewController.swift
//  TimeIt
//
//  Created by Yevhen Neydel on 8/24/19.
//  Copyright © 2019 neydel. All rights reserved.
//

import UIKit

var data: [[String: Any]] = [["miniName": "asdasdasd","didTask":true], ["miniName": "asdasdasd","didTask":true],["miniName": "asdasdasd","didTask":true],["miniName": "asdasdasd","didTask":true]]
var miniTasks: [MiniTask] = []
class OneTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timer: Timer?
    var inProccess = false
//    var newCell : TaskTableViewCell?
//    var tasksCash: [TaskTableViewCell] = []
//    private var task: Task = Task(name: "Unknown")
//    private var cellMe: TaskTableViewCell?
//    var miniContainer: MiniTableViewController = MiniTableViewController()
    
    @IBOutlet weak var myNavigate: UINavigationItem!
//    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var myTime: UILabel!
    @IBOutlet weak var comlitedSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNewSubtaskBtn: UIButton!
    
    var oneTask: Task?
    var savedTasks: [Task] = []
    var localTasks: [MiniTask] = []
//    private var tableMiniView: UITableView  {
//
//    }
//    {
//        didSet{
//            taskNameLabel.text = self.oneTask?.name
//            myTime.text = self.oneTask?.getTime()
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startSegueBack" {
            //            let vc = segue.source as? OneTaskViewController
            //        returnedCell = self.cell
            timerOff()
//            updateSubtaskList(mTasks: miniTasks)
            saveProccess()
            //        self.cell?.task?.setTime(settime: self.task.getMyTime())
            //            newCell = self.cellMe
            //            self.tasksCash.append(newCell!)
            //            vc!.tasks.append(self.cell.task!)
        } else if segue.identifier == "startSegueModal" {
            timerOff()
            saveProccess()
        } else if segue.identifier == "embedSegue" {
            //            if let vc = segue.destination as? MiniTableViewController,
            //                segue.identifier == "embedSegue" {
            //                print("sadasdasdasdasdasdasdadasdasda")
            //                self.miniTableView = vc
            //            } else {
            //
            //            }
            //            miEm?.setMiniTasks(munTas: (self.oneTask?.getAllMiniTasks())!)
        } else {
            print("Nothing")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewSubtaskBtn.frame.size.width = addNewSubtaskBtn.frame.size.height
        addNewSubtaskBtn.layer.cornerRadius = addNewSubtaskBtn.frame.size.width / 2
        timerControll.layer.cornerRadius = timerControll.frame.size.width / 2
        // Do any additional setup after loading the view.
//        taskNameLabel.text = self.myTasks?.getName()
        initializeOneTask()
        createTimer()
//        miniContainer.initiliazeMini(minTas: [["miniName":"asdasdadd", "didTask": true]])
    }
    
    private func initializeOneTask(){
        //        taskNameLabel.text = self.hash!.getName()
        //        checkCompleted(compl: self.hash!.getComplited())
        //        initTime(taskTime: self.hash!.getTime())
        myNavigate.title = self.oneTask?.name
//        taskNameLabel.text = self.oneTask?.name
        checkTime()
        initCompleted()
        miniTasks = []
        let newMiniN = self.oneTask?.getAllMiniTasks()
        for tsss in newMiniN! {
            miniTasks.append(MiniTask(name: tsss["miniName"] as! String, compl: (tsss["didTask"] as? Bool)! ))
//            print(tsss["didTask"])
        }
        tableView.reloadData()
//        miniTasks[0].setComplited(compl: true)
//        self.oneTask?.setNewMiniTask(miniNameTask: "Add")
//        print(self.oneTask?.getAllMiniTasks()[0])
//        miniTasks = initializeMiniTasks(taskss: self.oneTask!)
//        tableView.reloadData()
    }
    
    @IBAction func pushAddAction(_ sender: Any){
        let alertController = UIAlertController(title: "Create new subtask", message: nil , preferredStyle: .alert)
        alertController.addTextField {
            (textField) in
            textField.placeholder = "Enter task"
            
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default){
            (alert) in
        }
        
        let alertAction2 = UIAlertAction(title: "Create", style: .default){
            (alert) in
            let newItem = alertController.textFields![0].text
            self.addSubTask(subtaskName: newItem!)
        }
        
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    
    func addSubTask(subtaskName: String){
        let newSubTask: MiniTask = MiniTask(name: subtaskName, compl: false)
        miniTasks.append(newSubTask)
//        updateSubtaskList(mTasks: miniTasks)
        tableView.reloadData()
    }
    
    private func checkTime(){
        myTime.text = self.oneTask?.getTime()
    }

    private func initCompleted(){
        let compl:Bool = (self.oneTask?.getComplited())!
            comlitedSwitch.isOn = compl
    }
    private func setCompleted(coml: Bool){
        comlitedSwitch.isOn = coml
        self.oneTask?.setComplited(compl: coml)
    }
    
    private func initTime(taskTime: String){
        myTime.text = taskTime
    }
    
    private func timerOn(){
        self.inProccess = true
        timerControll.setImage(UIImage(named: "pause"), for: .normal)
    }
    
    private func timerOff(){
        self.inProccess = false;
        timerControll.setImage(UIImage(named: "play"), for: .normal)
    }
    
    @IBOutlet weak var timerControll: UIButton!
    @IBAction func stopTimer(_ sender: Any) {
        if inProccess {
            timerOff()
            saveProccess()
//            timerControll.backgroundColor = UIColor(named: "ndMainColor")
        } else {
            timerOn()
//            timerControll.backgroundColor = UIColor(named: "white")
        }
//        self.cell.task!.calculateDiff(endDate: Date())
    }
    
    @IBAction func compliteAction(_ sender: Any) {
        if comlitedSwitch.isOn == true {
            setCompleted(coml: false)
        } else {
            setCompleted(coml: true)
            timerOff()
        }
    }
//    func updateSubtaskList(mTasks: [MiniTask]){
    
//    }
    
    func saveProccess(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "OneTaskId")
        var saveArr: [[String: Any]] = []
        for tsk in savedTasks {
            if tsk.getName() == self.oneTask!.getName() {
                saveArr.append((self.oneTask?.getMe())!)
            } else {
                saveArr.append(tsk.getMe())
            }
        }
        defaults.set(saveArr, forKey: "oneTaskId")
        defaults.synchronize()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return miniTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miniCell", for: indexPath)
        
        //        if let cell = cell as? MiniTableViewCell{
        let currentItem = miniTasks[indexPath.row]
//        print(miniTasks[indexPath.row].getSelection())
        cell.textLabel?.text = currentItem.getName()
        cell.textLabel?.textColor = UIColor(named: "ndWhite")
        if currentItem.getSelection() == true {
            cell.accessoryType = .checkmark
            cell.backgroundColor = UIColor(named: "ndMainOpaced")
        } else {
            cell.accessoryType = .none
            cell.backgroundColor = .darkGray
        }
        //        }
        //        cell.textLabel?.text = data[indexPath.row]["miniName"] as! String
        return cell
    }
    
    //    Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            Delete; the row from the data source
            //            tableView.deleteRows(at: [indexPath], with: .fade)
            let rowNum : Int = indexPath.row
            miniTasks.remove(at: rowNum)
//            updateSubtaskList(mTasks: miniTasks)
            tableView.reloadData()
            
            //            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            //             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            print("editing")
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.oneTask?.updateSubTasks(subTasks: [])
        let newListMini: [MiniTask] = miniTasks
        for nLM in newListMini {
            if nLM.getName() == miniTasks[indexPath.row].getName() {
                var newSelection = true
                if nLM.getSelection() == true {
                    newSelection = false
                }
                self.oneTask?.setNewMiniTask(miniNameTask: nLM.getName(), didTask: newSelection)
            } else {
                self.oneTask?.setNewMiniTask(miniNameTask: nLM.getName(), didTask: nLM.getSelection())
            }
        }
        let nnMini: [[String:Any]] = (self.oneTask?.getAllMiniTasks())!
        miniTasks = []
        for nMini in nnMini {
            let myBool:Bool = (nMini["didTask"] as? Bool)!
            let newTask = MiniTask(name: nMini["miniName"] as! String, compl: myBool)
            newTask.setSelection(compl: myBool)
            miniTasks.append(newTask)
        }
//        miniTasks = (self.oneTask?.getMiniTaskList())!
//        for onne in miniTasks {
//            print(onne.getSelection())
//        }
        saveProccess()
        tableView.reloadData()
        print("Selected")
    }
}

// MARK: - Timer
extension OneTaskViewController {
    @objc func updateTimer() {
//        if ((cell as? TaskTableViewCell) != nil){
        if inProccess{
            self.oneTask?.addOne()
            checkTime()
            saveProccess()
//            cellMe!.timeLabel = myTime
        }
    }
    
    func createTimer() {
        // 1
        if timer == nil {
            // 2
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
        }
    }
}
