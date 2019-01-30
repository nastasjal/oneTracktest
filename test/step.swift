//
//  step.swift
//  test
//
//  Created by Анастасия Латыш on 28/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import Foundation



struct step : Codable {
    var aerobic: Int
    var run: Int
    var walk: Int
    var date: Int
    var sumOfSteps: Int  {
        return aerobic + run + walk
    }
}
    
  
