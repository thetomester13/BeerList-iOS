//
//  AddBreweryViewController.swift
//  Beer Club
//
//  Created by Tomer Shvueli on 5/2/16.
//  Copyright © 2016 TTSLucas. All rights reserved.
//

import UIKit
import Firebase

class AddBreweryViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var tourtimeTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet var addPhotoImageView: UIImageView!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddBreweryViewController.photoTapped))
        tapRecognizer.numberOfTapsRequired = 1
        addPhotoImageView.userInteractionEnabled = true
        addPhotoImageView.addGestureRecognizer(tapRecognizer)
        
        
        imagePicker = UIImagePickerController()
        //imagePicker.sourceType = .PhotoLibrary
        imagePicker.sourceType = .Camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self

    }
    
    func photoTapped(){
        self.presentViewController(imagePicker, animated: true, completion: nil)
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
            let image = self.addPhotoImageView.image
            let imageData = UIImageJPEGRepresentation(image!, 0.7)
            let base64String =  imageData?.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
            
            let newBreweryDict = [
                "name" : nameTextField.text,
                "nickname" : nicknameTextField.text,
                "tourTime" : tourtimeTextField.text,
                "description" : descriptionTextView.text,
                "logo" : base64String
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
                self.addPhotoImageView.image = UIImage(named: "beer")
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

//MARK: Image picker functions
extension AddBreweryViewController: UIImagePickerControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //gets called after photo selected
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.addPhotoImageView.image = selectedImage
            self.addPhotoImageView.contentMode = .ScaleAspectFit

        }
        
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //gets called when image cancelled
        self.imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
}
