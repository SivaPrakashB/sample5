//
//  UploadPicViewController.swift
//  MLM
//
//  Created by Apple on 02/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class UploadPicViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
      return IndicatorInfo(title: "UPLOAD PIC")
    }
    
    var picker1:UIImagePickerController? = UIImagePickerController()
    
    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var back12: UIButton!
    
 var popover1: UIPopoverController? = nil
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var choosePicButton: UIButton!
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
       
        choosePicButton.clipsToBounds=true
        choosePicButton.layer.cornerRadius=10
        choosePicButton.layer.borderWidth=1
        choosePicButton.layer.borderColor=UIColor.gray.cgColor
        submit.clipsToBounds=true
        submit.layer.cornerRadius=10
        submit.layer.borderWidth=1
        submit.layer.borderColor=UIColor.red.cgColor
        back12.clipsToBounds=true
        back12.layer.cornerRadius=10
        back12.layer.borderWidth=1
        back12.layer.borderColor=UIColor.red.cgColor
        image1.clipsToBounds=true
        image1.layer.cornerRadius=5
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ChoosePic(_ sender: UIButton) {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
            
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
            
        }
        
        // Add the actions
        picker1?.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the controller
        picker1?.modalPresentationStyle = .popover
        //picker1?.popoverPresentationController?.butt=sender
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            popover1 = UIPopoverController(contentViewController: alert)
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            picker1!.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker1!, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    func openGallary()
    {
        picker1!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(picker1!, animated: true, completion: nil)
        }
        else
        {
            popover1 = UIPopoverController(contentViewController: picker1!)
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        image1.image=info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func BACK(_ sender: UIButton) {
        
        let parent=self.parent as! MyProfileParentViewController
        parent.moveToViewController(at: 2)
        
        
        
    }
    
    

}
