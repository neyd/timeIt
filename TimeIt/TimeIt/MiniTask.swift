//
//  MiniTask.swift
//  TimeIt
//
//  Created by Yevhen Neydel on 8/25/19.
//  Copyright © 2019 neydel. All rights reserved.
//

import Foundation

class MiniTask {
    let name: String
    var completed : Bool
    
    init(name: String, compl: Bool) {
        self.name = name
        self.completed = compl
    }
    
    func getName() -> String {
        return self.name
    }
    
    func setSelection(compl: Bool){
        self.completed = compl
    }
    
    func getSelection() -> Bool {
        return self.completed
    }
}
