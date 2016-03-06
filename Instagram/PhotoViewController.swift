//
//  PhotoViewController.swift
//  Instagram
//
//  Created by Oranuch on 3/5/16.
//  Copyright © 2016 horizon. All rights reserved.
//

import UIKit
import MBProgressHUD

class PhotoViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var selectedImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeNavigationBar()
        selectedImageView.layer.borderWidth = 2
        selectedImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
    }
    
    func initializeNavigationBar(){
        self.navigationItem.title = "Upload"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
    }
    
    @IBAction func onCameraRollTap(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func imageTapped(img: AnyObject)
    {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            selectedImageView.image = editedImage
            dismissViewControllerAnimated(true, completion: { () -> Void in
            })
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func onUpload(sender: AnyObject) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        PostImage.postUserImage(selectedImageView.image, withCaption: captionTextField.text) { (success: Bool, error: NSError?) -> Void in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            if success {
                print("Posted to Parse")
                self.selectedImageView.image = nil
                self.captionTextField.text = ""
            }
            else {
                print("Can't post to parse")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
