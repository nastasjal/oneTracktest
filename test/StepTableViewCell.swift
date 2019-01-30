//
//  StepTableViewCell.swift
//  test
//
//  Created by Анастасия Латыш on 28/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit

class StepTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        layoutSubviews()
      //   setupView()
        // Initialization code
    }
    
    @IBOutlet weak var runCountLabel: UILabel!
    @IBOutlet weak var aerobicCountLabel: UILabel!
    @IBOutlet weak var walkCountLabel: UILabel!
//    func setupView(){
//        //Align Title
//        addSubview(stepLineView)
//        
//    }
//    
//    @IBOutlet weak var stepLineView: StepView! {
//        didSet {
//            layoutSubviews()
//        }
//    }
//
    @IBOutlet weak var countStepLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var stepLineView = StepView(frame: CGRect(x: 15, y: 50, width: 10, height: 10))
}
