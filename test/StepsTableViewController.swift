//
//  StepsTableViewController.swift
//  test
//
//  Created by Анастасия Латыш on 28/01/2019.
//  Copyright © 2019 Анастасия Латыш. All rights reserved.
//

import UIKit

class StepsTableViewController: UITableViewController {

    var steps:[step]? 
    var goal  =  GoalStore.searches {
        didSet {
            print ("goal was changed")
            self.tableView.reloadData()
        }
    }

    var sumOfSteps = 0
    
    var indentX:Int = 10
    var indentY: Int = 10
    var objectHeight: Int = 20
    var cellHeight: CGFloat = 100
    var cellWidth = 370
    var footerHeight: CGFloat = 40
    var headerHeight: CGFloat = 20
    var starSize: Int = 20
  
    
    @IBAction func changeGoal(_ sender: UIBarButtonItem) {
        let alert = UIAlertController (title: "change goal", message: "insert new goal", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textfield in
            textfield.placeholder = "goal"
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action: UIAlertAction ) -> Void in
            if let newGoal = alert.textFields?.first , let _ = Int(newGoal.text!) {
        GoalStore.add(newGoal.text!)
            self.goal = Int(newGoal.text!)!
            }}))
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       loadData()
    }
    
    
    func loadData(){
        let urlString = "https://intern-f6251.firebaseio.com/intern/metric.json"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            do {
                let articlesData = try JSONDecoder().decode([step].self, from: data)
                
                DispatchQueue.main.async {
                    self.steps = articlesData
                    self.tableView.reloadData()
                }
                print(articlesData)
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return steps?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return steps![section].sumOfSteps > goal ? 2 : 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
        case 0:
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepTableCell", for: indexPath)
            if let stepCell = cell as? StepTableViewCell {
                stepCell.dateLabel.text = String((steps![indexPath.section].date))
                stepCell.stepLineView.frame =  CGRect(x: indentX, y: indentY*2+objectHeight, width: indentX, height: indentY)
                stepCell.stepLineView.arraySteps = [StepView.step(type: StepView.stepType.aerobic, value: CGFloat(steps![indexPath.section].aerobic)), StepView.step(type: StepView.stepType.walk, value: CGFloat(steps![indexPath.section].walk)), StepView.step(type: StepView.stepType.run, value: CGFloat(steps![indexPath.section].run))]
                stepCell.countStepLabel.text = "\(String(steps![indexPath.section].sumOfSteps))/\(goal)steps"
                stepCell.aerobicCountLabel.attributedText = setFontToStepLabels(for: "aerobic", countSteps: steps![indexPath.section].aerobic, with: UIColor(hexString: "589CC3") )
                stepCell.walkCountLabel.attributedText = setFontToStepLabels(for: "walk", countSteps: steps![indexPath.section].walk, with: UIColor(hexString: "6FC4F6") )
                stepCell.runCountLabel.attributedText = setFontToStepLabels(for: "run", countSteps: steps![indexPath.section].run, with: UIColor(hexString: "376078") )
                cell.addSubview(stepCell.stepLineView)
                animatedLine(for: (stepCell.stepLineView))
            }
         return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "footerTableCell", for: indexPath)
                if let footerCell = cell  as? FooterTableViewCell {
                footerCell.goalReachLabel.text = "Goal Reached"
                footerCell.goalReachStarView.frame = CGRect(x: Int(cellWidth) - indentX - starSize , y: indentY, width: starSize, height: starSize)
                cell.addSubview(footerCell.goalReachStarView)
                    animatedStar(for: footerCell.goalReachStarView)
            }
            return cell
        
        }
    }
 
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return steps![indexPath.section].sumOfSteps > goal ? ( indexPath.row == 0 ? cellHeight : footerHeight ) : cellHeight
    }
    
    func animatedStar(for starView: UIView){
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3,
                                                       delay: 1,
                                                       options: [ .curveEaseIn],
                                                       animations: {starView.frame =  starView.frame.insetBy(dx: -8.0, dy: -8.0)}, completion: { position in
            UIView.transition(with: starView,
                              duration: 0.3,
                              options: [.curveEaseIn, .repeat],
                              animations: {UIView.setAnimationRepeatCount(3); starView.frame =  starView.frame.insetBy(dx: 8.0, dy: 8.0)})
        })
    }
    
    func animatedLine(for lineView: UIView){
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1,
                                                       delay: 0,
                                                       options: [.curveEaseOut],
                                                       animations: { lineView.frame = CGRect(x: self.indentX, y: self.indentY*2+self.objectHeight, width: Int(UIScreen.main.bounds.width) - self.indentY * 2 /*Int(self.cellWidth) - self.indentY*/, height: self.indentY)})
        
    }
    
    func setFontToStepLabels(for stepType: String, countSteps : Int, with color: UIColor) ->  NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: "")
        attributedText.append(NSAttributedString(string: "\(countSteps)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: stepType, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: color]))
        return attributedText
    }
    

}
