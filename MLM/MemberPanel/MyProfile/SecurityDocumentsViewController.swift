//
//  SecurityDocumentsViewController.swift
//  MLM
//
//  Created by Apple on 02/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class SecurityDocumentsViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "DOCUMENTS")
    }
    
 var picker1:UIImagePickerController? = UIImagePickerController()
    var base64StringAdharCard=String()
    var base64StringPanCard=String()
    var base64StringVoterID=String()
    var base64StringPassPort=String()
    var base64StringDrivingLicense=String()
    var base64StringBankBook=String()
    var selection=0
    
    @IBOutlet weak var back12: UIButton!
    @IBOutlet weak var panCardLabel: UILabel!
    @IBOutlet weak var adharCardLabel: UILabel!
    @IBOutlet weak var next123: UIButton!
    var popover1: UIPopoverController? = nil
    
    @IBOutlet weak var VoterIDCardLabel: UILabel!
    
    @IBOutlet weak var passportLabel: UILabel!
    
    
    @IBOutlet weak var drivingLicenseLabel: UILabel!
    
    @IBOutlet weak var bankBookLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        next123.clipsToBounds=true
        next123.layer.cornerRadius=10
        next123.layer.borderWidth=1
        next123.layer.borderColor=UIColor.red.cgColor
        
        back12.clipsToBounds=true
        back12.layer.cornerRadius=10
        back12.layer.borderWidth=1
        back12.layer.borderColor=UIColor.red.cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        switch selection {
        case 1:
            let data:NSData=UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.0) as! NSData
            let strBase64 = data.base64EncodedString(options:.lineLength64Characters)
            let trimmedString:String = strBase64.trimmingCharacters(in: .whitespaces)
            adharCardLabel.text="Adhar.png"
            base64StringAdharCard=trimmedString
             self.dismiss(animated: true, completion: nil)
           
        case 2:
            let data:NSData=UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.0) as! NSData
            let strBase64 = data.base64EncodedString(options:.lineLength64Characters)
            let trimmedString:String = strBase64.trimmingCharacters(in: .whitespaces)
            
            base64StringPanCard=trimmedString
            panCardLabel.text="PanCard.png"
            self.dismiss(animated: true, completion: nil)
            
        case 3:
            let data:NSData=UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.0) as! NSData
            let strBase64 = data.base64EncodedString(options:.lineLength64Characters)
            let trimmedString:String = strBase64.trimmingCharacters(in: .whitespaces)
            
            base64StringVoterID=trimmedString
            VoterIDCardLabel.text="VoterID.png"
            self.dismiss(animated: true, completion: nil)
        case 4:
            let data:NSData=UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.0) as! NSData
            let strBase64 = data.base64EncodedString(options:.lineLength64Characters)
            let trimmedString:String = strBase64.trimmingCharacters(in: .whitespaces)
            passportLabel.text="Passport.png"
            base64StringPassPort=trimmedString
            
         self.dismiss(animated: true, completion: nil)
        case 5:
            let data:NSData=UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.0) as! NSData
            let strBase64 = data.base64EncodedString(options:.lineLength64Characters)
            let trimmedString:String = strBase64.trimmingCharacters(in: .whitespaces)
            
            base64StringDrivingLicense=trimmedString
            drivingLicenseLabel.text="drivingLicense.png"
            self.dismiss(animated: true, completion: nil)
        case 6:
            let data:NSData=UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.0) as! NSData
            let strBase64 = data.base64EncodedString(options:.lineLength64Characters)
            let trimmedString:String = strBase64.trimmingCharacters(in: .whitespaces)
            
            base64StringBankBook=trimmedString
            bankBookLabel.text="BankBook.png"
           self.dismiss(animated: true, completion: nil)
        default:
            break
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
    
    
    @IBAction func ChooseAdharCard(_ sender: UIButton) {
        selection=1
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
    
    @IBAction func choosePAnCard(_ sender: UIButton) {
        selection=2
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
    
    @IBAction func ChooseVoterIDCard(_ sender: UIButton) {
        selection=3
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
    
    @IBAction func ChooseVoterIDImage(_ sender: UIButton) {
        selection=4
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
    
    @IBAction func ChooseDrivingLicense(_ sender: Any) {
        selection=5
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
    
    
    @IBAction func BankBookBearingPhotograph(_ sender: UIButton) {
        selection=6
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
    
    
    @IBAction func nextPage(_ sender: UIButton) {
        
        if base64StringAdharCard.isEmpty==true && base64StringAdharCard=="" && base64StringPanCard.isEmpty==true && base64StringPanCard=="" && base64StringVoterID.isEmpty==true && base64StringVoterID=="" && base64StringPassPort.isEmpty==true && base64StringPassPort=="" && base64StringDrivingLicense.isEmpty==true && base64StringDrivingLicense=="" && base64StringBankBook.isEmpty==true && base64StringBankBook=="" {
            let alert=UIAlertController(title: "Alert", message: "Kindly Select At Least One Document", preferredStyle: .alert
            )
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            let parent=self.parent! as! MyProfileParentViewController
            parent.moveToViewController(at: 3)
        }
        
    }
   
    
    @IBAction func AdharRemove(_ sender: UIButton) {
        base64StringAdharCard=String()
        adharCardLabel.text="Select Adhar Card Image"
    }
    
    @IBAction func panCardRemove(_ sender: UIButton) {
        base64StringPanCard=String()
        panCardLabel.text="Select Pan Card Image"
    }
    
    @IBAction func voterIDRemove(_ sender: Any) {
        base64StringVoterID=String()
        VoterIDCardLabel.text="Select Voter ID Image"
    }
    
    @IBAction func passportRemove(_ sender: Any) {
        base64StringPassPort=String()
        passportLabel.text="Select Pass Port Image"
    }
    
    @IBAction func drivingLIcenseRemove(_ sender: UIButton) {
    base64StringDrivingLicense=String()
        drivingLicenseLabel.text="Select Driving License"
    }
    
    @IBAction func BankBookRemove(_ sender: UIButton) {
    base64StringBankBook=String()
        bankBookLabel.text="Select Bank Book Bearing Photograph"
    }
    
    @IBAction func BACK(_ sender: UIButton) {
        let parent=self.parent! as! MyProfileParentViewController
        parent.moveToViewController(at: 1)
        
    }
}
