//
//  PreferencesTableViewController.swift
//  UAP
//
//  Created by Adrian Bolinger on 4/18/16.
//  Copyright © 2016 NoVA. All rights reserved.
//

import UIKit

class PreferencesTableViewController: UITableViewController {
    
    let animator = Animator()

    @IBOutlet weak var loopSwitch: UISwitch!
    @IBOutlet weak var shuffleSwitch: UISwitch!
    
    // loopDefault
    // shuffleDefault
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        print("prefsVC loaded")
        super.viewDidLoad()
        checkDefaultValues()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func checkDefaultValues() {
        if defaults.valueForKey("loopDefault") == nil {
            loopSwitch.on = false;
        }
        
        if defaults.valueForKey("shuffleDefault") == nil {
            shuffleSwitch.on = false
        }
    }
    


    @IBAction func loopDefaultAction(sender: AnyObject) {
        print("loopDefaultAction")
        if loopSwitch.on {
            defaults.setBool(true, forKey: "loopDefault")
        } else {
            defaults.setBool(false, forKey: "loopDefault")
        }
        print(defaults.valueForKey("loopDefault"))
        animator.animateControl(loopSwitch)
        
    }
    
    @IBAction func shuffleDefaultAction(sender: AnyObject) {
        print("shuffleDefaultAction")
        
        if shuffleSwitch.on {
            defaults.setBool(true, forKey: "shuffleDefault")
        } else {
            defaults.setBool(false, forKey: "shuffleDefault")
        }
        
        animator.animateControl(shuffleSwitch)
        print(defaults.valueForKey("shuffleDefault"))
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
