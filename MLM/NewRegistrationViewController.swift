//
//  NewRegistrationViewController.swift
//  MLM
//
//  Created by Apple on 16/06/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class NewRegistrationViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var jod: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var image1: UIImageView!
    var gendersList=["Male","Female"]
    var selectPositionList=["Left","Right"]
    var picker1:UIImagePickerController? = UIImagePickerController()
    var popover1: UIPopoverController? = nil
    @IBOutlet weak var selectPositionLabel: UILabel!
    @IBOutlet weak var selectPositiontableView: UITableView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderTableView: UITableView!
    @IBOutlet weak var fullName: UITextField!
    
    @IBOutlet weak var cityView: UIView!
    
    @IBOutlet weak var selectPositionView: UIView!
    @IBOutlet weak var stateView: UIView!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var DateOFBirth: UITextField!
    
    @IBOutlet weak var mobileNumber: UITextField!
    
    
    @IBOutlet weak var emailID: UITextField!
    
    @IBOutlet weak var confirmEmailID: UITextField!
    
    
    @IBOutlet weak var joiningDate: UITextField!
    
    
    @IBOutlet weak var Address: UITextView!
    
    
    
    @IBOutlet weak var sponserID: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userID: UITextField!
    
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genderTableView.separatorStyle = .none
        
        Address.clipsToBounds=true
        Address.layer.borderWidth=0.5
        
        Address.layer.cornerRadius=5
        Address.layer.borderColor=UIColor.lightGray.cgColor
        genderView.clipsToBounds=true
        genderView.layer.borderWidth=0.5
        
        genderView.layer.cornerRadius=5
        genderView.layer.borderColor=UIColor.lightGray.cgColor
        
        
        
        countryView.clipsToBounds=true
        countryView.layer.borderWidth=0.5
        countryView.layer.cornerRadius=5
        countryView.layer.borderColor=UIColor.lightGray.cgColor
        
        
        stateView.clipsToBounds=true
        stateView.layer.borderWidth=0.5
        stateView.layer.cornerRadius=5
        stateView.layer.borderColor=UIColor.lightGray.cgColor
        
        
        
        cityView.clipsToBounds=true
        cityView.layer.borderWidth=0.5
        cityView.layer.cornerRadius=5
        cityView.layer.borderColor=UIColor.lightGray.cgColor
        
        
        selectPositionView.clipsToBounds=true
        selectPositionView.layer.borderWidth=0.5
        selectPositionView.layer.cornerRadius=5
        selectPositionView.layer.borderColor=UIColor.lightGray.cgColor
        
        
        
        
        
        
         fullName.delegate=self
        
          DateOFBirth.delegate=self
        
          mobileNumber.delegate=self
        
        
        emailID.delegate=self
        
        confirmEmailID.delegate=self
        
        
       joiningDate.delegate=self
        
        
       Address.delegate=self
        
        
        
       sponserID.delegate=self
        
       userPassword.delegate=self
       userID.delegate=self
        
        
        confirmPassword.delegate=self
        genderTableView.delegate=self
        genderTableView.dataSource=self
        genderTableView.isHidden=true
        
        selectPositiontableView.delegate=self
        selectPositiontableView.dataSource=self
        selectPositiontableView.isHidden=true
        selectPositiontableView.separatorStyle = .none
        
        createDatePicker()
        createDatePicker1()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        /*Member
          Panel*/
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        fullName.resignFirstResponder()
        
        DateOFBirth.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        
        
        emailID.resignFirstResponder()
        
        confirmEmailID.resignFirstResponder()
        
        
        joiningDate.resignFirstResponder()
        
        
        //  Address.delegate=self
        
        
        
        sponserID.resignFirstResponder()
        
        userPassword.resignFirstResponder()
        userID.resignFirstResponder()
        
        confirmPassword.resignFirstResponder()
        
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    
    @IBAction func genderSelection(_ sender: Any) {
        if genderTableView.isHidden==true
        {
            genderTableView.isHidden=false
        }
        else
        {
            genderTableView.isHidden=true
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView==genderTableView
        {
        let cell=genderTableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text=gendersList[indexPath.row]
        return cell
        }
        else
        {
            let cell=selectPositiontableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text=selectPositionList[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView==genderTableView{
        genderLabel.text=gendersList[indexPath.row]
        genderTableView.isHidden=true
        }
        else
        {
            selectPositionLabel.text=selectPositionList[indexPath.row]
            selectPositiontableView.isHidden=true
        }
    }
    
    @IBAction func selectPosition(_ sender: UIButton) {
        
        if selectPositiontableView.isHidden==true
        {
            selectPositiontableView.isHidden=false
            
        }
        else
        {
             selectPositiontableView.isHidden=true
        }
        
    }
    
    @IBAction func choosePic(_ sender: Any) {
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        /* print(info)
         guard let imageId = info["UIImagePickerControllerReferenceURL"] else {
         return
         }
         print(imageId,"******************************")*/
        
        image1.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        let data:NSData=UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage] as! UIImage,0.0) as! NSData
        let strBase64 = data.base64EncodedString(options:.lineLength64Characters)
        let trimmedString:String = strBase64.trimmingCharacters(in: .whitespaces)
        print("******\(strBase64)**********")
       // base64String=trimmedString
        self.dismiss(animated: true, completion: nil)
        
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
    var picker=UIDatePicker()
    func createDatePicker()
    {let toolBar11=UIToolbar()
        toolBar11.sizeToFit()
        //Done Button
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar11.setItems([done], animated: false)
        
        dob.inputAccessoryView=toolBar11
        dob.inputView=picker
        picker.datePickerMode = .date
        
    }
    @objc func donePressed()
    {
        
        let formatter1=DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none
        formatter1.dateFormat="yyyy-MM-dd"
        //  dateForServer=formatter1.string(from: picker.date)
        //
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat="dd/MM/yyyy"
        dob.text=formatter.string(from: picker.date)
        //  getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    func createDatePicker1()
    {let toolBar11=UIToolbar()
        toolBar11.sizeToFit()
        //Done Button
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        toolBar11.setItems([done], animated: false)
        
        jod.inputAccessoryView=toolBar11
        jod.inputView=picker
        picker.datePickerMode = .date
        
    }
    @objc func donePressed1()
    {
        
        let formatter1=DateFormatter()
        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none
        formatter1.dateFormat="yyyy-MM-dd"
        //  dateForServer=formatter1.string(from: picker.date)
        //
        let formatter=DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat="dd/MM/yyyy"
        jod.text=formatter.string(from: picker.date)
        //  getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    
    
}
