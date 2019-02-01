//
//  StepTableViewCell.swift
//  test
//
//  Created by Анастасия Латыш on 28/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit

class StepTableViewCell: UITableViewCell {

    var indentX:Int = 10
    var indentY: Int = 10
    var objectHeight: Int = 20
    
    lazy var stepLineView = StepView()// (frame: CGRect(x: indentX, y: indentY*2+objectHeight, width: indentX, height: indentY))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutSubviews()
      //  addConstraint(for: stepLineView)
    }
    
    @IBOutlet weak var runCountLabel: UILabel!
    @IBOutlet weak var aerobicCountLabel: UILabel!
    @IBOutlet weak var walkCountLabel: UILabel!
    @IBOutlet weak var countStepLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func addConstraint(for viewStep: UIView) {
        let viewLeadingConstraint = NSLayoutConstraint(item: viewStep, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal
            , toItem: viewStep, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        let viewTrailingConstraint = NSLayoutConstraint(item: viewStep, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal
            , toItem: viewStep, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([viewLeadingConstraint, viewTrailingConstraint])
    }
    
}
