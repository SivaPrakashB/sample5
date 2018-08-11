//
//  VerifyOTPViewController.swift
//  MLM
//
//  Created by Apple on 27/06/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class VerifyOTPViewController: UIViewController,UITextFieldDelegate,XMLParserDelegate {
var selection=0
    var mobileNumber=String()
    var saveElementName=String()
    var saveResult=String()
    @IBOutlet weak var enterOTP: UITextField!
    @IBOutlet weak var showdowView: UIView!
    var imageView=UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        enterOTP.delegate=self
        showdowView.layer.shadowColor = UIColor.black.cgColor
        showdowView.layer.shadowOpacity = 1
        showdowView.layer.shadowOffset = CGSize.zero
        showdowView.layer.shadowRadius = 8
        showdowView.layer.shouldRasterize = true
        
        showdowView.layer.shadowPath = UIBezierPath(rect: showdowView.bounds).cgPath
    }
    override func viewWillAppear(_ animated: Bool) {
        mobileNumber=UserDefaults.standard.object(forKey: "mobileNumber") as! String
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterOTP.resignFirstResponder()
        return true
    }

    @IBAction func verify(_ sender: UIButton) {
        if enterOTP.text?.isEmpty==true || enterOTP.text==""
        {
            let alert = UIAlertController(title: "Alert", message: "Enter The OTP", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let jeremyGif = UIImage.gifImageWithName("preloader")
            imageView = UIImageView(image: jeremyGif)
            
            imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 50 , y: (self.view.frame.size.height/2)-50, width: 100, height: 100)
            self.view.addSubview(imageView)
            self.view.isUserInteractionEnabled=false
        selection=0
        verifyOTP()
        }
        
    }
    
    @IBAction func resend(_ sender: UIButton) {
        let jeremyGif = UIImage.gifImageWithName("preloader")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 50 , y: (self.view.frame.size.height/2)-50, width: 100, height: 100)
        self.view.addSubview(imageView)
        self.view.isUserInteractionEnabled=false
        

        selection=1
        sendOTP()
    }
    func verifyOTP()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><VerifyOTP xmlns=\"http://tempuri.org/\"><number>\(mobileNumber)</number><OTP>\(enterOTP.text!)</OTP><SecurityKey>MLM@#4321</SecurityKey></VerifyOTP></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/VerifyOTP", forHTTPHeaderField: "SOAPAction")
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
                    if self.verifyResult=="0"
                    {
                        
                        self.imageView.isHidden=true
                        self.view.isUserInteractionEnabled=true
                        let alert = UIAlertController(title: "Alert", message: "Enter Valid OTP", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        /* let alert = UIAlertController(title: "Alert", message: "OTP Verified Successfully", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)*/
                        self.selection=2
                        self.saveData()
                        
                    }
                }
                
            }
        })
        task.resume()
        
    }
    func sendOTP()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SendOTP xmlns=\"http://tempuri.org/\"><number>\(mobileNumber)</number><SecurityKey>MLM@#4321</SecurityKey></SendOTP></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/SendOTP", forHTTPHeaderField: "SOAPAction")
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
                    if self.otpResult=="0"
                    {
                        self.imageView.isHidden=true
                        self.view.isUserInteractionEnabled=true

                        let alert = UIAlertController(title: "Alert", message: "Please Try Again Later", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                       
                        self.imageView.isHidden=true
                        self.view.isUserInteractionEnabled=true

                        let alert = UIAlertController(title: "Alert", message: "OTP has been send to Your Mobile Number,Check Your Mobile For OTP", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
                
            }
        })
        task.resume()
        
    }
    func saveData()
    {
        /*"\(self.fullNameTextField.text!)"+"^"+"\(self.dateOfBirthTextField.text!)"+"^"+"\(self.genderLabel.text!)"+"^"+"\(self.countryID)"+"^"+"\(self.countryLabel.text!)"+"^"+"\(self.stateID)"+"^"+"\(self.stateLabel.text!)"+"^"+"\(self.enterTheCityTextField.text!)"+"^"+"\(self.mobileNumberTextField.text!)"+"^"+"\(self.emailIDTextField.text!)"+"^"+"\(self.sponserIDNew)"+"^"+"\(self.positionLabel.text!)"
        */
        
        var saveData=UserDefaults.standard.object(forKey: "passData") as! String
        var saveDataArray=saveData.components(separatedBy: "^")
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><Save_Menber_Registraions xmlns=\"http://tempuri.org/\"><Name>\(saveDataArray[0])</Name><dob>\(saveDataArray[1])</dob><Gender>\(saveDataArray[2])</Gender><CountryID>\(saveDataArray[3])</CountryID><CountryName>\(saveDataArray[4])</CountryName><StateID>\(saveDataArray[5])</StateID><StateName>\(saveDataArray[6])</StateName><CityName>\(saveDataArray[7])</CityName><MobileNo>\(saveDataArray[8])</MobileNo><Email>\(saveDataArray[9])</Email><Addr>0</Addr><parent>\(saveDataArray[10])</parent><Side>\(saveDataArray[11])</Side><MemberPicBinaryData>0</MemberPicBinaryData></Save_Menber_Registraions></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/Save_Menber_Registraions", forHTTPHeaderField: "SOAPAction")
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
                    if self.saveResult=="0"
                    {                        self.imageView.isHidden=true
                        self.view.isUserInteractionEnabled=true

                        let alert = UIAlertController(title: "Alert", message: "Please Try Again Later", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                       
                        self.imageView.isHidden=true
                        self.view.isUserInteractionEnabled=true

                        var userNameAndPassword=self.saveResult.components(separatedBy: "^")
                        if userNameAndPassword.count==2
                        {
                            UserDefaults.standard.set(userNameAndPassword[0], forKey: "userName")
                            UserDefaults.standard.set(userNameAndPassword[1], forKey: "password")
                            
                            let st=UIStoryboard(name: "Main", bundle: nil)
                            let vc=st.instantiateViewController(withIdentifier: "memberPanel") as! UIViewController
                            self.present(vc, animated: true, completion: nil)
                            
                        }
                        else
                        {
                            let alert = UIAlertController(title: "Alert", message: "\(self.saveResult)", preferredStyle: .alert)
                            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)

                        }
                        
                    }
                }
                
            }
        })
        task.resume()
        
    }
    
    
    
    
    var elementValue: String?
    var countryElementValue:String?
    var otpElementValue=String()
    var otpResult=String()
    var verifyResult=String()
    
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "VerifyOTPResult" {
            elementValue = String()
        }
       
        if elementName == "SendOTPResult" {
            otpElementValue = String()
        }
        if elementName == "Save_Menber_RegistraionsResult" {
            saveElementName = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection == 0 {
            elementValue! += string
            verifyResult=elementValue!
              print(verifyResult,"verifyResult")
        }
        
        if otpElementValue != nil && selection == 1 {
            otpElementValue += string
            otpResult=otpElementValue
            print(otpResult,"otpResult")
        }
        if saveElementName != nil && selection == 2 {
            saveElementName += string
            saveResult=saveElementName
            print(saveResult,"saveResult")
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "VerifyOTPResult" {
            elementValue = String()
            
        }
        
        if elementName == "SendOTPResult" {
            otpElementValue = String()
        }
        if elementName == "Save_Menber_RegistraionsResult" {
            saveElementName = String()
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
}
