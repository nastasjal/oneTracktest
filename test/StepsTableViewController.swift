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
    var goal = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
                //print(articlesData)
                  self.steps = articlesData
            self.tableView.reloadData()
                 }
                print(articlesData)
            } catch let jsonError {
                print(jsonError)
            }
            //  return  stepLoaded
            
            }.resume()
        
    
       
       
    }
    
    func loadData(handler: @escaping ([step]?) -> Void){
        var stepLoaded : [step]?
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
               // DispatchQueue.main.async {
                    //print(articlesData)
                 //   self.steps = articlesData
                    stepLoaded = articlesData
                     handler(stepLoaded)
               // }
                print(articlesData)
            } catch let jsonError {
                print(jsonError)
            }
           //  return  stepLoaded
            
            }.resume()
        
    }
    
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return steps?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepTableCell", for: indexPath) as? StepTableViewCell

        cell?.dateLabel.text = String(Double(steps![indexPath.row].date))
    //   cell?.stepLineView.arraySteps = [StepView.step(type: StepView.stepType.aerobic, value: CGFloat(steps![indexPath.row].aerobic)), StepView.step(type: StepView.stepType.walk, value: CGFloat(steps![indexPath.row].walk)), StepView.step(type: StepView.stepType.run, value: CGFloat(steps![indexPath.row].run))]
        let woView = StepView(frame: CGRect(x: 15, y: 50, width: 375, height: 10))
        woView.arraySteps = [StepView.step(type: StepView.stepType.aerobic, value: CGFloat(steps![indexPath.row].aerobic)), StepView.step(type: StepView.stepType.walk, value: CGFloat(steps![indexPath.row].walk)), StepView.step(type: StepView.stepType.run, value: CGFloat(steps![indexPath.row].run))]
        cell?.countStepLabel.text = String(Double(woView.sumSteps))
        cell?.aerobicCountLabel.text = String(steps![indexPath.row].aerobic)
        cell?.walkCountLabel.text = String(steps![indexPath.row].walk)
        cell?.runCountLabel.text = String(steps![indexPath.row].run)
    /*    for subview in cell!.subviews{
            subview.removeFromSuperview();
        }*/
        
        // then add your view
        cell!.addSubview(woView)
        
        return cell!
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
