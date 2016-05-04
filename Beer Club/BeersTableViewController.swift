//
//  BeersTableViewController.swift
//  Beer Club
//
//  Created by DeShawn Brown on 4/27/16.
//  Copyright © 2016 TTSLucas. All rights reserved.
//

import UIKit
import Firebase

class BeersTableViewController: UITableViewController {

    let reuseID = "BeerCell"
    var breweries = [Brewery]()
    var loadingIdicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        loadingIdicator = UIActivityIndicatorView(frame: CGRect(x: (self.tableView.frame.size.width/2 - 20) , y: (self.tableView.frame.size.height/2 - 20 ) , width: 40, height: 40))
        
        loadingIdicator.color = UIColor.redColor()
        
        tableView.registerNib(UINib(nibName: "BeerTableViewCell", bundle: nil), forCellReuseIdentifier: reuseID)

        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.tableView.addSubview(loadingIdicator)
        loadingIdicator.startAnimating()
        
        

        self.navigationItem.title = "Beer List"

        //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(BeersTableViewController.addBeer))
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let ref = Firebase(url:"https://beer-finder.firebaseio.com/breweries")
        
        // Attach a closure to read the data at our posts reference
        ref.observeEventType(.Value, withBlock: { snapshot in // Reads data from the database
            //print("Did load objects")
            
            print(snapshot.value)
            
            var newItems = [Brewery]()
            
            for item in snapshot.children {
                let brewery = Brewery(snapshot: item as! FDataSnapshot)
                newItems.append(brewery)
            }
            
            self.breweries = newItems
            self.tableView.reloadData()
            self.loadingIdicator.stopAnimating()
            
           // self.renderViews()
            
            //breweries = snapshot.value
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        print("At end of view did load")

    }
    
    func addBeer(){
        self.performSegueWithIdentifier("addBrewery", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.breweries.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110.0
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            
            let currentBrewery = self.breweries[indexPath.row]
            let ref = Firebase(url:"https://beer-finder.firebaseio.com/breweries/\(currentBrewery.id)")
                        
            ref.removeValue()

            print("action is  \(action) and indexpath is \(indexPath)")
        }
        
        return [deleteAction]
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath) as! BeerTableViewCell

        let currentBrewery = self.breweries[indexPath.row]
        
        // Configure the cell...
        cell.beerNameLabel.text = currentBrewery.nickname
        cell.beerImageView.image = UIImage(named: currentBrewery.logo)

        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentBrewery = self.breweries[indexPath.row]
        print(currentBrewery.name)
        
        self.performSegueWithIdentifier("showDetails", sender: indexPath)
    }
 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetails" {
            let detailedBreweryViewController = segue.destinationViewController as! DetailedBreweryViewController
            
            let indexPath = sender as! NSIndexPath
            detailedBreweryViewController.brewery = breweries[indexPath.row]
            //detailedBreweryViewController.breweryIndex = breweryButton.tag
            
        }
    }
    
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
