//
//  MemberPanelViewController.swift
//  MLM
//
//  Created by Apple on 28/06/18.
//  Copyright © 2018 senovTech. All rights reserved.
//
//Users/Apple/Desktop/IconsForMLM/iOSDevCenters+GIF.swift


import UIKit

class MemberPanelViewController: UIViewController,XMLParserDelegate {
    
    @IBOutlet weak var joindate: UILabel!
    
    @IBOutlet weak var statusNameLabel: UILabel!
    @IBOutlet weak var statusName: UIView!
    @IBOutlet weak var statusColorView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var myProfile: UILabel!
    @IBOutlet weak var textDisplayLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobilenumber: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var memberID: UILabel!
    @IBOutlet weak var userImage1: UIImageView!
    @IBOutlet weak var memberPanelView: UIView!
    @IBOutlet weak var wemartView: UIView!
    @IBOutlet weak var textView: UIView!
    
    
    @IBOutlet weak var myProfileLockView: UIView!
    
    @IBOutlet weak var assignSalesIDLockView: UIView!
    @IBOutlet weak var addMemberLockView: UIView!
    @IBOutlet weak var myNetworkLockView: UIView!
    
    @IBOutlet weak var myAccountLockView: UIView!
    
    @IBOutlet weak var manageSalesIDLockView: UIView!
    
    @IBOutlet weak var editProfileLockView: UIView!
    
    @IBOutlet weak var paymentReqstLockView: UIView!
    
    @IBOutlet weak var myTargetsLockView: UIView!
    
    
    var memberID1=String()
    var usertype1=String()
    var mobileNumber1=String()
    var email1=String()
    var joinDate1=String()
    var textDisplay1=String()
    var base65String1=String()
    
    var imageView=UIImageView()
   let greenColor=UIColor(red: 0, green: 143, blue: 0, alpha: 1)
    var getDataResult=String()
    var getDataResultArray=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     /*   self.myProfileLockView.isHidden=true
        self.myAccountLockView.isHidden=true
        self.myNetworkLockView.isHidden=true
        self.manageSalesIDLockView.isHidden=true
        self.editProfileLockView.isHidden=true
        self.myTargetsLockView.isHidden=true
        self.paymentReqstLockView.isHidden=true
        self.addMemberLockView.isHidden=true
        self.assignSalesIDLockView.isHidden=true*/
        
       let jeremyGif = UIImage.gifImageWithName("preloader")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 50 , y: (self.view.frame.size.height/2)-50, width: 100, height: 100)
        self.view.addSubview(imageView)
        self.view.isUserInteractionEnabled=false

        
        
        userImage1.clipsToBounds=true
        userImage1.layer.cornerRadius=50
        userImage1.layer.borderWidth=2
        userImage1.layer.borderColor=UIColor.gray.cgColor
        statusColorView.clipsToBounds=true
        statusColorView.layer.cornerRadius=8
        
        
       /* textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 1
        textView.layer.shadowOffset = CGSize.zero
        textView.layer.shadowRadius = 8
        textView.layer.shouldRasterize = true
        textView.layer.shadowPath = UIBezierPath(rect: textView.bounds).cgPath
        
        */
        
        
        
        wemartView.layer.shadowColor = UIColor.black.cgColor
        wemartView.layer.shadowOpacity = 1
        wemartView.layer.shadowOffset = CGSize.zero
        wemartView.layer.shadowRadius = 4
        wemartView.layer.shouldRasterize = true
        wemartView.layer.shadowPath = UIBezierPath(rect: wemartView.bounds).cgPath
        
        
        memberPanelView.layer.shadowColor = UIColor.black.cgColor
        memberPanelView.layer.shadowOpacity = 1
        memberPanelView.layer.shadowOffset = CGSize.zero
        memberPanelView.layer.shadowRadius = 4
        memberPanelView.layer.shouldRasterize = true
        memberPanelView.layer.shadowPath = UIBezierPath(rect: memberPanelView.bounds).cgPath
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        getData()
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        getDataResultArray=[String]()
        let jeremyGif = UIImage.gifImageWithName("preloader")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 50 , y: (self.view.frame.size.height/2)-50, width: 100, height: 100)
        self.view.addSubview(imageView)
        self.view.isUserInteractionEnabled=false
        getData()
      /*  let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "home") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button click...")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)*/
    }

    @IBAction func logOFF(_ sender: UIButton) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to Logout?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "home") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button click...")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
        
    }
    
    //convert base64 String to Image
    
    
    
    /*
     
     
     
     
     
 let dataDecoded : Data = Data(base64Encoded: strBase64, options: .ignoreUnknownCharacters)!
 let decodedimage = UIImage(data: dataDecoded)
 yourImageView.image = decodedimage
     
     class func convertImageToBase64(image: UIImage) -> String {
     let imageData = UIImagePNGRepresentation(image)!
     return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
     }
     
     //
     // Convert base64 to String
     //
     class func convertBase64ToImage(imageString: String) -> UIImage {
     let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
     return UIImage(data: imageData)!
     }
     
     
     
     
     
     */
    func getData()
    {  let username=UserDefaults.standard.object(forKey: "username1") as! String
        let password=UserDefaults.standard.object(forKey: "password1") as! String
       
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetMemberDetails xmlns=\"http://tempuri.org/\"><MemberID>\(username)</MemberID><SecurityKey>MLM@#4321</SecurityKey></GetMemberDetails></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/GetMemberDetails", forHTTPHeaderField: "SOAPAction")
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
                     print(self.getDataResultArray,"getDataResultArray")
                   
                    self.imageView.isHidden=true
                    self.view.isUserInteractionEnabled=true
                    
                    
                    if self.getDataResultArray.count==9
                    {self.memberID1=self.getDataResultArray[0]
                        self.usertype1=self.getDataResultArray[2]
                        self.mobileNumber1=self.getDataResultArray[3]
                        self.email1=self.getDataResultArray[4]
                        self.joinDate1=self.getDataResultArray[5]
                       // self.textDisplay1=dummyArray[5]
                        self.memberID.text="Member ID-"+self.getDataResultArray[0]
                        self.name.text=self.getDataResultArray[1]
                        
                         self.userType.text="User Type-"+self.getDataResultArray[2]
                        self.mobilenumber.text="Mobile-"+self.getDataResultArray[3]
                        self.email.text="Email-"+self.getDataResultArray[4]
                        self.joindate.text="Joining Date-"+self.getDataResultArray[5]
                        self.statusNameLabel.text=self.getDataResultArray[6]
                        
                        
                        if self.getDataResultArray[6] == "Active" && self.getDataResultArray[7] == "0"
                        { self.textDisplayLabel.isHidden=false
                            self.myProfile.text="COMPLETE PROFILE"
                            self.textDisplayLabel.text="Note: Complete Your Profile To Unlock All The Features"
                            self.statusColorView.backgroundColor=UIColor.green
                            self.myProfileLockView.isHidden=true
                            
                            
                            
                            self.myAccountLockView.isHidden=false
                            self.myNetworkLockView.isHidden=false
                            self.manageSalesIDLockView.isHidden=false
                            self.editProfileLockView.isHidden=false
                            self.myTargetsLockView.isHidden=false
                            self.paymentReqstLockView.isHidden=false
                            self.addMemberLockView.isHidden=false
                            self.assignSalesIDLockView.isHidden=false
                        }
                        else if self.getDataResultArray[6] == "Active" && self.getDataResultArray[7] == "1"
                        { self.myProfileLockView.isHidden=false
                            
                            self.myAccountLockView.isHidden=false
                            self.myNetworkLockView.isHidden=false
                            self.manageSalesIDLockView.isHidden=false
                            self.editProfileLockView.isHidden=false
                            self.myTargetsLockView.isHidden=false
                            self.paymentReqstLockView.isHidden=false
                            self.addMemberLockView.isHidden=false
                            self.assignSalesIDLockView.isHidden=false
                            self.textDisplayLabel.isHidden=false
                            self.myProfile.text="PROFILE VERYFYING"
                            self.textDisplayLabel.text="Profile Completed Awaiting Verifying"
                            self.statusColorView.backgroundColor=self.greenColor
                        }
                        else if self.getDataResultArray[6] == "Run"
                        {
                            self.myProfileLockView.isHidden=true
                            self.myAccountLockView.isHidden=true
                            self.myNetworkLockView.isHidden=true
                            self.manageSalesIDLockView.isHidden=true
                            self.editProfileLockView.isHidden=true
                            self.myTargetsLockView.isHidden=true
                            self.paymentReqstLockView.isHidden=true
                            self.addMemberLockView.isHidden=true
                            self.assignSalesIDLockView.isHidden=true
                            
                            
                            self.myProfile.text="MY PROFILE"
                           self.textDisplayLabel.isHidden=true
                            self.statusColorView.backgroundColor=UIColor.blue
                        }
                        else if self.getDataResultArray[6] == "Open"
                        {
                            self.myProfileLockView.isHidden=true
                            self.myAccountLockView.isHidden=true
                            self.myNetworkLockView.isHidden=true
                            self.manageSalesIDLockView.isHidden=true
                            self.editProfileLockView.isHidden=true
                            self.myTargetsLockView.isHidden=true
                            self.paymentReqstLockView.isHidden=true
                            self.addMemberLockView.isHidden=true
                            self.assignSalesIDLockView.isHidden=true
                            self.myProfile.text="MY PROFILE"
                            self.textDisplayLabel.isHidden=true
                            self.statusColorView.backgroundColor=UIColor.red
                        }
                        DispatchQueue.global().async {
                            let url = URL(string:self.getDataResultArray[8])
                            
                            let imageData = try? Data(contentsOf: url!)
                            
                            DispatchQueue.main.sync {
                                
                               self.userImage1.image = UIImage(data: imageData!)
                                
                                
                            }
                        }
                        //self.textDisplayLabel.text="\(self.textDisplay1)"
                    }
                    if self.getDataResult=="0"
                    {
                        self.imageView.isHidden=true
                        self.view.isUserInteractionEnabled=true
                        let alert = UIAlertController(title: "Alert", message: "Mobile number already Exist. Plese Choose Another one", preferredStyle: .alert)
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
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetMemberDetailsResult" {
            elementValue = String()
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil{
            
            getDataResultArray.append(string)
           
            
        }
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetMemberDetailsResult" {
            elementValue = String()
            
        }
        
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    
}
