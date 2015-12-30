//
//  ViewController.swift
//  meme
//
//  Created by SwagSoft Vn on 12/29/15.
//  Copyright © 2015 SwagSoft Vn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var textTop:UITextField!
    @IBOutlet weak var textBot:UITextField!
    

    let memeTextAttributes = [
        NSStrokeColorAttributeName : "black",
        NSForegroundColorAttributeName : "white",
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : "5.0"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textBot.delegate = self
        textTop.delegate = self
        
        textTop.textAlignment = NSTextAlignment.Center
        textBot.textAlignment = NSTextAlignment.Center
        
        textTop.keyboardType = UIKeyboardType.Default
        textBot.keyboardType = UIKeyboardType.Default
   
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    override func viewWillAppear(animated: Bool) {
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        textBot.text = "text Botton"
        textTop.text = "text Top"
        textTop.backgroundColor = UIColor.clearColor()
        textBot.backgroundColor = UIColor.clearColor()
        
        subscribeToKeyboardNotifications()
    }
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
 
//    
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
//        textField.text = ""
//        return true
//    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let newtext = textField.text! + string;
        
        
        
        //textField.frame.size.width = CGFloat (10 + newtext.characters.count)
        
        textField.frame.size.width.advancedBy(CGFloat (10 + newtext.characters.count))
        
        textField.text = newtext
        print("in processing....\(string)::\(textField.frame.size.width)")
        return true
        
    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            print("dismissing....")
            
        })
        
        imagePickerView.image = image
        
    }

    

    @IBAction func PickAnImage(sender: UIBarButtonItem) {
        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
//            print("Button capture......")
        
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            textTop.hidden = false
            textBot.hidden = false
            textTop.enabled = true
            textBot.enabled = true
//        }
    }
    @IBAction func pickAnImageFromCamera (sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
        self.presentViewController(imagePicker, animated: true, completion: nil)
        textTop.hidden = false
        textBot.hidden = false
        textTop.enabled = true
        textBot.enabled = true
    }
    
    
    func generateMemedImage() -> UIImage
    {
        toolbar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    @IBAction func loadImage(sender: UIBarButtonItem){
        imagePickerView.image = generateMemedImage()
        textTop.hidden = true
        textBot.hidden = true
        textTop.enabled = false
        textBot.enabled = false
        toolbar.hidden = false
    }

}

