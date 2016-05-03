//
//  AddBreweryViewController.swift
//  Beer Club
//
//  Created by Tomer Shvueli on 5/2/16.
//  Copyright © 2016 TTSLucas. All rights reserved.
//

import UIKit
import Firebase

class AddBreweryViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var tourtimeTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nameTextField.resignFirstResponder()
        nicknameTextField.resignFirstResponder()
        tourtimeTextField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            print("completed")
        }
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let nameValid     = (nameTextField.text?.characters.count > 0)
        let nicknameValid = (nicknameTextField.text?.characters.count > 0)
        let tourTimeValid = (tourtimeTextField.text?.characters.count > 0)
        let descValid     = (descriptionTextView.text != "Brewery description...")
        
        if (nameValid && nicknameValid && tourTimeValid && descValid) {
            
            print("let user save")
            
            let newBreweryDict = [
                "name" : nameTextField.text,
                "nickname" : nicknameTextField.text,
                "tourTime" : tourtimeTextField.text,
                "description" : descriptionTextView.text
            ]
            
            let ref = Firebase(url:"https://beer-finder.firebaseio.com/breweries")
            
            let newChildRef = ref.childByAutoId()
            print(newChildRef.key)
            newChildRef.setValue(newBreweryDict)
            
            let alertController = UIAlertController(title: "Saved!", message: "What would you like to do next?", preferredStyle: .Alert)
            
            let backAction = UIAlertAction(title: "Go back to List", style: .Default, handler: { (action:UIAlertAction) in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(backAction)
            
            let resetAction = UIAlertAction(title: "Add Another!", style: .Default, handler: { (action:UIAlertAction) in
                self.nameTextField.text = ""
                self.nicknameTextField.text = ""
                self.tourtimeTextField.text = ""
                self.descriptionTextView.text = "Brewery description..."
            })
            alertController.addAction(resetAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Not Complete", message: "Please fill in all values to save!", preferredStyle: .Alert)

            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertController.addAction(okAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
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
