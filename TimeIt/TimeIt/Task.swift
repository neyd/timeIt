/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

class Task {
    let name: String
    var creationDate = Date()
    var completed = false
    var myTime: Int = 0
    private var miniOfTask: [[String: Any]] = []
    var isSelect: Bool = false
  
    init(name: String) {
        self.name = name
    }
    
    func initSaved(creation: Date = Date(), complete:Bool = false,time: Int = 0) {
        self.creationDate = creation
        self.completed = complete
        self.myTime = time
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getCreation() -> Date {
        return self.creationDate
    }
    
    func getComplited() -> Bool {
        return self.completed
    }
    
    func setComplited(compl: Bool){
        self.completed = compl
    }
    
    func getTime() -> String {
        let time = self.myTime
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        var times: [String] = []
        if hours > 0 {
            times.append("\(hours):")
        } else if hours < 9 {
            times.append("0\(hours):")
        } else {
            times.append("00:")
        }
        if minutes > 9 {
            times.append("\(minutes):")
        } else if minutes < 10 {
            times.append("0\(minutes):")
        } else  {
            times.append("00:")
        }
        if seconds < 10 {
        times.append("0\(seconds)")
        } else {
            times.append("\(seconds)")
        }
        
        let timeLabel = times.joined(separator: "")
        return timeLabel
    }
    
    func getMyTime() -> Int {
        return self.myTime
    }
    
    func setTime(settime: Int) {
        self.myTime = settime
    }
    
    func getMe() -> [String: Any] {
//        print(self.miniOfTask)
        return ["Name": self.name,"Creation": self.creationDate,"Completed": self.completed,"myTime":self.myTime,"miniTasks": self.miniOfTask]
    }
    
    func getTask() -> Task {
        return self
    }
    
//    func calculateDiff(endDate: Date) {
//        let newTime:Int = Int(Date().timeIntervalSince(endDate) - Date().timeIntervalSince(self.creationDate))
//        addToTime(difference: newTime)
//    }
    
    func addOne(){
        self.myTime += 1
    }
    
    func setNewMiniTask(miniNameTask: String, didTask: Bool) {
        self.miniOfTask.append(["miniName": miniNameTask, "didTask": didTask])
    }
    
    func getAllMiniTasks() -> [[String: Any]] {
        return self.miniOfTask
    }
    
    func getMiniTaskList() -> [MiniTask] {
        var returnedList: [MiniTask] = []
        for oneMiniTask in self.miniOfTask {
            let newMiniTask = MiniTask(name: oneMiniTask["miniName"] as! String, compl:
                (oneMiniTask["didTask"] as? Bool)!)
//            print(oneMiniTask)
            returnedList.append(newMiniTask)
        }
        return returnedList
    }
    
    func updateSubTasks(subTasks: [MiniTask]){
        self.miniOfTask = []
        var newSubList: [[String: Any]] = []
        for sub in subTasks {
            newSubList.append(["miniName": sub.name, "didTask": sub.completed])
        }
        
        self.miniOfTask = newSubList
    }
    
//    func updateTime(){
//        self.myTime =
//    }
    
    func isSelected() -> Bool {
        return isSelect
    }
    
    func selectThis(){
        isSelect = true
    }
    
    func deSelectThis(){
        isSelect = false
    }
}
