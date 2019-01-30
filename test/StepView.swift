//
//  StepView.swift
//  test
//
//  Created by Анастасия Латыш on 28/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit

class StepView: UIView {
    
    struct step {
        var type: stepType
        var value: CGFloat
        
        init (type: stepType, value: CGFloat){
            self.value = value
            self.type = type
        }
    }
    //MARK: to do comment values
   /* var arraySteps = [step] () {
        didSet {
            layoutSubviews()
        }
    }*/
    var arraySteps = [step(type: stepType.run, value: 13), step(type: stepType.aerobic, value: 22), step(type: stepType.walk, value: 45)] {
        didSet {
            layoutSubviews()
        }
    }
    
    enum stepType: String {
        case run
        case walk
        case aerobic
    }
    
    var stepTypeColor: [stepType: UIColor] = [stepType.aerobic: UIColor.red, stepType.run: UIColor.green,stepType.walk: UIColor.blue]
   
    var sumSteps: CGFloat {
        return arraySteps.map({$0.value}).reduce(0, +)
    }
    
    func getPercent(for stepType: step)-> CGFloat {
        return  (stepType.value*100)/sumSteps
    }
    
    var maxLength: CGFloat {
        return bounds.width
    }
    
 /*   var height: CGFloat {
        return bounds.height/3
    }*/
    var maxHeight: CGFloat {
        return bounds.height
    }
    
    private func createLabelType(for step: step) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "\(String(step.type.rawValue))\n \(String(Double(step.value)))"
        //label.text = String(Double(step.value))
        addSubview(label)
        return label
    }
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     let stepRect = UIBezierPath(roundedRect: rect, cornerRadius: 5)
        UIColor.white.setFill()
        stepRect.fill()
        var previusX: CGFloat = 0
        arraySteps.forEach{ (step) in
            let width = maxLength * getPercent(for: step)/100
            let frame = CGRect(x: previusX, y: bounds.minY, width: width, height: maxHeight)
            let stepPath = UIBezierPath(roundedRect: frame, cornerRadius: 5)
            stepTypeColor[step.type]?.setFill()
            stepPath.fill()
            stepPath.close()
        //    var labelType = createLabelType(for: step)
        //    labelType.frame = CGRect(x: previusX, y: bounds.minY + height, width: width, height: maxHeight/3)
        //    labelType.textAlignment = .center
            previusX += width
            
        }
     }
    
 
    
}
