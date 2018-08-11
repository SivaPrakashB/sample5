//
//  bankDetailsViewController.swift
//  MLM
//
//  Created by Apple on 02/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class bankDetailsViewController: UIViewController,UITextFieldDelegate,XMLParserDelegate,IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BANK DETAILS")
    }
    var bankDetailsResult=String()
    var activeTextField=UITextField()
    @IBOutlet weak var bankName: UITextField!
    
    @IBOutlet weak var branchName: UITextField!
    
    @IBOutlet weak var ifscCode: UITextField!
    
    @IBOutlet weak var accountNumber: UITextField!
    
    @IBOutlet weak var next123: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        next123.clipsToBounds=true
        next123.layer.cornerRadius=10
        next123.layer.borderWidth=1
        next123.layer.borderColor=UIColor.red.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    

    @IBAction func submit(_ sender: UIButton) {
        if bankName.text?.isEmpty==true || bankName.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter Bank Name", preferredStyle: .alert
            )
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        else if branchName.text?.isEmpty==true || branchName.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The Branch Name", preferredStyle: .alert
            )
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        else if ifscCode.text?.isEmpty==true || ifscCode.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The IFSC Code", preferredStyle: .alert
            )
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        else if accountNumber.text?.isEmpty==true || accountNumber.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The Account Number", preferredStyle: .alert
            )
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let parent=self.parent! as! MyProfileParentViewController
            parent.moveToViewController(at: 1)
        }
       
        
     
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField=textField
    }
    
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeTextField.resignFirstResponder()
        return true
    }
    
    
    
    func LogIN()
    {
        
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><Menber_Login xmlns=\"http://tempuri.org/\"><MemberID>username</MemberID><Pass>password.text</Pass><SecurityKey>MLM@#4321</SecurityKey></Menber_Login></soap:Body></soap:Envelope>"
        print(is_SoapMessage)
        let is_URL: String = "http://wservice.mlm.senoverp.com/Wservicemlm.asmx?"
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("wservice.mlm.senoverp.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/Menber_Login", forHTTPHeaderField: "SOAPAction")
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            // print("Response: \(response)")
            if data != nil
            {
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                //print("Body: \(strData)")
                let XMLparser = XMLParser(data: data!)
                XMLparser.delegate = self
                XMLparser.parse()
                //XMLparser.shouldResolveExternalEntities = true
                
                if error != nil
                {
                    print("Error: " + error!.localizedDescription)
                }
                DispatchQueue.main.async {
                   
                    
                    
                }
                
            }
        })
        task.resume()
        
    }
    
    var elementValue: String?
    
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Menber_LoginResult" {
            elementValue = String()
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil  {
            elementValue! += string
            bankDetailsResult=elementValue!
            print(bankDetailsResult,"loginResult")
        }
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Menber_LoginResult" {
            elementValue = String()
            
        }
        
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    @objc func keyboardDidShow(notification: Notification) {
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let parent=self.parent! as! MyProfileParentViewController
        let keyboardY = parent.containerView.frame.size.height - keyboardSize.height
        
        let editingTextFieldY:CGFloat! = self.activeTextField.frame.origin.y
        
        if self.view.frame.origin.y >= 0 {
            //Checking if the textfield is really hidden behind the keyboard
            if editingTextFieldY > keyboardY - 60 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    parent.view.frame = CGRect(x: 0, y: 0 - (editingTextFieldY! - (keyboardY - 60)), width: parent.view.bounds.width,height: parent.view.bounds.height)
                }, completion: nil)
            }
        }
        
        
        
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let parent=self.parent! as! MyProfileParentViewController
        //self.view.frame = CGRect(x: 0, y: 0,width: self.view.bounds.width, height: self.view.bounds.height)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            parent.view.frame = CGRect(x: 0, y:0,width: parent.view.bounds.width,height: parent.view.bounds.height)
        }, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    
}
