//
//  ViewController.swift
//  meme
//
//  Created by SwagSoft Vn on 12/29/15.
//  Copyright © 2015 SwagSoft Vn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imagePickerView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        imagePickerView.image = image
        
    }
 

    @IBAction func PickAnImage(sender: UIBarButtonItem) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("Button capture......")
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }

}

