//
//  ViewController.swift
//  Beer Club
//
//  Created by Schvindt, Lucas S on 4/18/16.
//  Copyright © 2016 TTSLucas. All rights reserved.
//

import UIKit
import Firebase

class MasterBreweryViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var masterBrewView0: UIView!
    @IBOutlet weak var masterBrewView1: UIView!
    @IBOutlet weak var masterBrewView2: UIView!
    
    var breweries = BreweryList().breweries
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            
            //self.renderViews()
            
            //breweries = snapshot.value
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        print("At end of view did load")
        
    }
    
    func renderViews() {
        //array of views
        let breweryViews = [masterBrewView0, masterBrewView1, masterBrewView2]
        print("Here")
        
        for index in 0..<breweryViews.count {
        
        let brewery = breweries[index]
        
        let breweryView = breweryViews[index]
        
        for subview in breweryView.subviews as [UIView] {
        
        if let label = subview as? UILabel {
        label.text = brewery.nickname
        }
        if let logo = subview as? UIImageView {
        logo.image = UIImage(named: brewery.logo)
        }
        
        }
        
        breweryViews[index].tag = index
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showBreweryDetail" {
            let detailedBreweryViewController = segue.destinationViewController as! DetailedBreweryViewController
            
            let breweryButton = sender!.view as UIView!
            detailedBreweryViewController.brewery = breweries[breweryButton.tag]
            //detailedBreweryViewController.breweryIndex = breweryButton.tag
           
        }
    }

    @IBAction func showBreweryDetail(sender: AnyObject) {
        
        self.performSegueWithIdentifier("showBreweryDetail", sender: sender)
    }

}

