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
    var goal = 4000
    var cellSpacingHeight = 15
    var sumOfSteps = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    /*    let urlString = "https://intern-f6251.firebaseio.com/intern/metric.json"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let articlesData = try JSONDecoder().decode([step].self, from: data)
                
                //Get back to the main queue
                 DispatchQueue.main.async {
                  self.steps = articlesData
            self.tableView.reloadData()
                 }
                print(articlesData)
            } catch let jsonError {
                print(jsonError)
            }
            
            }.resume()
        
 */
       
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let urlString = "https://intern-f6251.firebaseio.com/intern/metric.json"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let articlesData = try JSONDecoder().decode([step].self, from: data)
                
                //Get back to the main queue
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
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepTableCell", for: indexPath) as? StepTableViewCell

        cell?.dateLabel.text = String(Double(steps![indexPath.section].date))
        
        cell?.stepLineView.arraySteps = [StepView.step(type: StepView.stepType.aerobic, value: CGFloat(steps![indexPath.section].aerobic)), StepView.step(type: StepView.stepType.walk, value: CGFloat(steps![indexPath.section].walk)), StepView.step(type: StepView.stepType.run, value: CGFloat(steps![indexPath.section].run))]
        cell?.countStepLabel.text = "\(String(steps![indexPath.section].sumOfSteps))/\(goal)steps"
        cell?.aerobicCountLabel.text = String(steps![indexPath.section].aerobic)
        cell?.walkCountLabel.text = String(steps![indexPath.section].walk)
        cell?.runCountLabel.text = String(steps![indexPath.section].run)
        // then add your view
        cell!.addSubview((cell?.stepLineView)!)
        animatedLine(for: (cell?.stepLineView)!)
        return cell!
    }
 
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return steps![section].sumOfSteps > goal ? CGFloat(cellSpacingHeight) : 0
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if steps![section].sumOfSteps > goal {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width:375 , height: cellSpacingHeight))
        let footerViewLabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width:360 , height: 20))
        footerViewLabel.text = "Goal reached"
        footerViewLabel.numberOfLines = 0;
        footerViewLabel.sizeToFit()
        let starView = GoalReachedStar(frame: CGRect(x: 350, y: 5, width: 20, height: 20))
        footerView.addSubview(footerViewLabel)
        footerView.addSubview(starView)
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 2, options: [ .curveLinear], animations: {starView.frame =  starView.frame.insetBy(dx: -4.0, dy: -4.0)}, completion: { position in
                UIView.transition(with: starView, duration: 2, options: .curveLinear, animations: {starView.frame =  starView.frame.insetBy(dx: 4.0, dy: 4.0)}
                )
            } )
            
            
            return footerView
            
        }
        return nil
    }
  /*  override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let stepLineView = cell.contentView.viewWithTag(indexPath.section) as? StepView {
            stepLineView.alpha = 0
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let stepLineView = cell.contentView.viewWithTag(indexPath.section) as? StepView {
            animatedLine(for: stepLineView)
        }
    }
    */
  /*  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
      /*  cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.05 * Double(indexPath.section),
            animations: {
                cell.alpha = 1
        })*/
        
        if let stepLineView = cell.viewWithTag(indexPath.section) as? StepView {
        animatedLine(for: stepLineView)
        }
    }*/
    
 
  
    func animatedLine(for lineView: UIView){
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 5, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState, .overrideInheritedCurve], animations: { lineView.frame = CGRect(x: 15, y: 50, width: 355, height: 10)} )
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
