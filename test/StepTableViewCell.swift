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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

}
