//
//  StepView.swift
//  test
//
//  Created by Анастасия Латыш on 28/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit

class StepView: UIView {
    
    var indentX:Int = 10
    var indentY: Int = 10
    var objectHeight: Int = 20
    
    struct step {
        var type: stepType
        var value: CGFloat
        
        init (type: stepType, value: CGFloat){
            self.value = value
            self.type = type
        }
    }

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
    
    var stepTypeColor: [stepType: UIColor] = [stepType.aerobic: UIColor(hexString: "589CC3") /*589CC3*/, stepType.run: UIColor(hexString: "376078") /*376078*/,stepType.walk: UIColor(hexString: "6FC4F6") /*6FC4F6*/]
   
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

     override func draw(_ rect: CGRect) {
        var previusX: CGFloat = 0
        arraySteps.forEach{ (step) in
            let width = maxLength * getPercent(for: step)/100
            let frame = CGRect(x: previusX, y: bounds.minY, width: width, height: maxHeight)
            let stepPath = UIBezierPath(roundedRect: frame, cornerRadius: 5)
            UIColor.black.setStroke()
            stepPath.stroke()
            stepTypeColor[step.type]?.setFill()
            stepPath.fill()
            stepPath.close()
        //    var labelType = createLabelType(for: step)
        //    labelType.frame = CGRect(x: previusX, y: bounds.minY + height, width: width, height: maxHeight/3)
        //    labelType.textAlignment = .center
            previusX += width
            
        }
     }
    
    @objc func updateLayout(){
     
            self.frame = CGRect(x: self.indentX, y: self.indentY*2+self.objectHeight, width: Int(UIScreen.main.bounds.width) - self.indentY * 2 /*Int(self.cellWidth) - self.indentY*/, height: self.indentY)
     
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(updateLayout), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIDevice.orientationDidChangeNotification,
                                                  object: nil)
    }
    
}

extension UIColor {
    convenience init(hexString: String, alpha:CGFloat? = 1.0) {
        var hexInt: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
