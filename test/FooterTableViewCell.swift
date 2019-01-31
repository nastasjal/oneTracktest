//
//  FooterTableViewCell.swift
//  test
//
//  Created by Анастасия Латыш on 31/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit

class FooterTableViewCell: UITableViewCell {

    var goalReachStarView = GoalReachedStar(frame: CGRect(x: 350, y: 5, width: 20, height: 20)) {
        didSet {
             layoutSubviews()
        }
    }
    
    @IBOutlet weak var goalReachLabel: UILabel!
    
    
}
