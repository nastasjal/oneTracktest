//
//  SaveGoal.swift
//  test
//
//  Created by Анастасия Латыш on 31/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import Foundation

struct GoalStore {
    
    private static let defaults = UserDefaults.standard
    private static let key = "Goal"
    
    static var goalDefault: Int = 3000
    
    static var searches: Int {
        return (defaults.object(forKey: key) as? Int) ?? self.goalDefault
    }
    
    static func add(_ element: String) {
        defaults.set(Int(element), forKey: key)
    }
    
    
}
