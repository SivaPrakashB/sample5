//
//  LoginViewController.swift
//  MLM
//
//  Created by Apple on 15/06/18.
//  Copyright © 2018 senovTech. All rights reserved.


import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate,XMLParserDelegate {
   var imageView=UIImageView()
   var loginResult=String()
    override func viewDidLoad() {
        super.viewDidLoad()
        login.clipsToBounds=true
        login.layer.cornerRadius=10
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var login: UIButton!
    
    @IBOutlet weak var password: UITextField!
    @IBAction func loginButtonAction(_ sender: UIButton) {
        
        if username.text?.isEmpty==true || username.text == ""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The UserName", preferredStyle: .alert
            )
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if password.text?.isEmpty==true || password.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The Password", preferredStyle: .alert)
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
          LogIN()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        username.resignFirstResponder()
        password.resignFirstResponder()
        
        return true
    }
    
    
    
    
    
    func LogIN()
    {
       
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><Menber_Login xmlns=\"http://tempuri.org/\"><MemberID>\(username.text!)</MemberID><Pass>\(password.text!)</Pass><SecurityKey>MLM@#4321</SecurityKey></Menber_Login></soap:Body></soap:Envelope>"
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
                print("Body: \(strData)")
                let XMLparser = XMLParser(data: data!)
                XMLparser.delegate = self
                XMLparser.parse()
                //XMLparser.shouldResolveExternalEntities = true
                
                if error != nil
                {
                    print("Error: " + error!.localizedDescription)
                }
                DispatchQueue.main.async {
                    if self.loginResult=="1"
                    {self.imageView.isHidden=true
                        UserDefaults.standard.set(self.username.text!, forKey: "username1")
                        UserDefaults.standard.set(self.password.text!, forKey: "password1")
                        self.view.isUserInteractionEnabled=true
                        let st=UIStoryboard(name: "Main", bundle: nil)
                        let vc=st.instantiateViewController(withIdentifier: "memberPanel") as! UIViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                    else{
                        
                        
                        self.imageView.isHidden=true
                        self.view.isUserInteractionEnabled=true

                        let alert=UIAlertController(title: "Alert", message: "Invalid ID and Password", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                   
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
          loginResult=elementValue!
            print(loginResult,"loginResult")
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
