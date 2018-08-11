//
//  KYCViewController.swift
//  MLM
//
//  Created by Apple on 02/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class KYCViewController: UIViewController,UITextFieldDelegate,XMLParserDelegate,IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "USER DETAILS")
    }
    
   
    @IBOutlet weak var back12: UIButton!
    
var marriedStatus=String()
    var kycResult=String()
    @IBOutlet weak var next123: UIButton!
    
    @IBOutlet weak var adharCardNumber: UITextField!
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var panNUmber: UITextField!
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func next(_ sender: UIButton) {
        if address.text?.isEmpty==true || address.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The Address", preferredStyle: .alert
            )
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        else if adharCardNumber.text?.isEmpty==true || adharCardNumber.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The Adhar Card Number", preferredStyle: .alert
            )
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        else if panNUmber.text?.isEmpty==true || panNUmber.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The PAN Number", preferredStyle: .alert
            )
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let parent=self.parent! as! MyProfileParentViewController
            parent.moveToViewController(at: 2)
        }
    
        
    }
    
    
    @IBAction func BACK(_ sender: UIButton) {
        let parent=self.parent! as! MyProfileParentViewController
        parent.moveToViewController(at: 0)
    }
    
    
    
    @IBAction func married(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
          marriedStatus = "UnMarried";
        case 1:
            marriedStatus = "Married";
        default:
            break
        }
        
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        address.resignFirstResponder()
        adharCardNumber.resignFirstResponder()
        panNUmber.resignFirstResponder()
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
            kycResult=elementValue!
            print(kycResult,"loginResult")
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
}
