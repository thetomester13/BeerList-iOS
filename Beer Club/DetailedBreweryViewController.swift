//
//  DetailedBreweryViewController.swift
//  Beer Club
//
//  Created by Schvindt, Lucas S on 4/18/16.
//  Copyright © 2016 TTSLucas. All rights reserved.
//

import UIKit

class DetailedBreweryViewController: UIViewController {

    @IBOutlet weak var breweryNameLabel: UILabel!
    @IBOutlet weak var tourInfoLabel: UILabel!
    @IBOutlet weak var breweryDescriptionLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var tourTimes: UILabel!
    @IBOutlet weak var mapsButton: UIButton!
    
    var breweryIndex: Int = 0
    
    var myTourTimeColor:UIColor! = UIColor.cyanColor()
    
    var myTourTimeText:String! = ""
    
    var myTourInfoLabelText:String! = ""
    
    let breweryList = BreweryList()
    
    var brewery: Brewery = Brewery(id: "1", name: "Birdsong", nickname: "Birdsong", logo: "birdsong.png", description: "Birdsong Brewing was founded in 2011 by a group of friends who share a love for both great beer and great people. We started with a five-gallon soup kettle and a vision inspired by some of our favorite craft breweries. The idea was simple: brew flavorful, unfiltered quality craft beer and bring that to Charlotte, NC.", tourTime: "Thursdays at 6:30pm", addressLink: "http://maps.apple.com/?address=1016,North+Davidson+Street,Charlotte,North+Carolina")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //brewery = breweryList.breweries[breweryIndex]
        
        self.title = brewery.nickname
        breweryNameLabel.text = brewery.name
        tourTimes.text = brewery.tourTime
        tourInfoLabel.text = myTourInfoLabelText
        tourTimes.textColor = myTourTimeColor
        breweryDescriptionLabel.text = brewery.description
        logoImage.image = UIImage(named: brewery.logo)
    }
    
    @IBAction func mapsButtonTapped(sender: AnyObject) {
        if let url = NSURL(string: brewery.addressLink) {
            UIApplication.sharedApplication().openURL(url)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
