//
//  ViewController.swift
//  test
//
//  Created by Анастасия Латыш on 28/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let stepLineView = StepView(frame: CGRect(x: 15, y: 50, width: 10, height: 50))
        self.view.addSubview(stepLineView)
        animatedLine(for: stepLineView)
    }

   
    
    func animatedLine(for lineView: UIView){
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 5, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState, .overrideInheritedCurve], animations: { lineView.frame = CGRect(x: 15, y: 50, width: 370, height: 50)} )

    }
    

}

