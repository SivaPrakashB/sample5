//
//  BasicDetailsViewController.swift
//  MLM
//
//  Created by Apple on 13/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class BasicDetailsViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate,IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BASIC DETAILS")
    }
    
    var gendersList=["Male","Female"]
    var selectPositionList=["Left","Right"]
    var countryDummyList=["India","Sri Lanka"]
    var countryIDS=[String]()
    var countryList=[String]()
    var stateList=[String]()
    var cityList=[String]()
    var countryResult=String()
    var stateResult=String()
    var cityResult=String()
    var selection:Int=0
    var countrySelection=0
    var countryID=String()
    var stateIDs=[String]()
    var sponserIDResult=String()
    var sponserIDValue=String()
    var otpElementValue=String()
    var otpResult=String()
    var stateID=String()
    var sponserIDNew=String()
    @IBOutlet weak var stateTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var enterTheCityTextField: UITextField!
    @IBOutlet weak var selectPositionTableView: UITableView!
    var picker=UIDatePicker()
    
    
    @IBOutlet weak var scrollView1: UIScrollView!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var emailIDTextField: UITextField!
    
    @IBOutlet weak var genderTableview: UITableView!
    @IBOutlet weak var sponserIDTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    var imageView=UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("First View")
        let jeremyGif = UIImage.gifImageWithName("preloader")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 50 , y: (self.view.frame.size.height/2)-50, width: 100, height: 100)
        self.view.addSubview(imageView)
        self.view.isUserInteractionEnabled=false
        
        
        
        fullNameTextField.delegate=self
        dateOfBirthTextField.delegate=self
        mobileNumberTextField.delegate=self
        emailIDTextField.delegate=self
        sponserIDTextField.delegate=self
        enterTheCityTextField.delegate=self
        createDatePicker()
        genderTableview.isHidden=true
        selectPositionTableView.isHidden=true
        // Do any additional setup after loading the view.
        genderTableview.delegate=self
        genderTableview.dataSource=self
        selectPositionTableView.delegate=self
        selectPositionTableView.dataSource=self
        genderTableview.separatorStyle = .none
        selectPositionTableView.separatorStyle = .none
        genderLabel.textColor=UIColor.lightGray
        countryLabel.textColor=UIColor.lightGray
        positionLabel.textColor=UIColor.lightGray
        stateTableView.isHidden=true
        stateTableView.separatorStyle = .none
        
        getCountryList()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var stateTableView: UITableView!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fullNameTextField.resignFirstResponder()
        dateOfBirthTextField.resignFirstResponder()
        mobileNumberTextField.resignFirstResponder()
        emailIDTextField.resignFirstResponder()
        sponserIDTextField.resignFirstResponder()
        enterTheCityTextField.resignFirstResponder()
        
        return true
    }
    func createDatePicker()
    {let toolBar11=UIToolbar()
        toolBar11.sizeToFit()
        //Done Button
        let done=UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolBar11.setItems([done], animated: false)
        
        dateOfBirthTextField.inputAccessoryView=toolBar11
        dateOfBirthTextField.inputView=picker
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
        dateOfBirthTextField.text=formatter.string(from: picker.date)
        //  getTheGraphDataFromTheServer()
        self.view.endEditing(true)
        
    }
    
    @IBAction func genderSelectAction(_ sender: UIButton) {
        countrySelection=0
        genderTableview.reloadData()
        if genderTableview.isHidden==true
        {
            genderTableview.isHidden=false
        }
        else
        {
            genderTableview.isHidden=true
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==stateTableView
        {
            return stateList.count
        }
        else
        {
            return 2
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView==genderTableview && countrySelection==0
        {
            let cell=genderTableview.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text=gendersList[indexPath.row]
            return cell
        }
        else if tableView==genderTableview && countrySelection==1
        {
            let cell=genderTableview.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text=countryList[indexPath.row]
            return cell
        }
        else if tableView==stateTableView
        {
            let cell=stateTableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text=stateList[indexPath.row]
            return cell
        }
        else
        {
            let cell=selectPositionTableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
            cell.textLabel?.text=selectPositionList[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView==genderTableview && countrySelection==0{
            genderLabel.textColor=UIColor.black
            genderLabel.text=gendersList[indexPath.row]
            genderTableview.isHidden=true
        }
        else if tableView==genderTableview && countrySelection==1{
            countryLabel.textColor=UIColor.black
            countryLabel.text=countryList[indexPath.row]
            countryID=countryIDS[indexPath.row]
            stateLabel.text=""
            stateTableView.isHidden=true
            selection=1
            stateList=[String]()
            stateIDs=[String]()
            getStateList()
            genderTableview.isHidden=true
        }
        else if tableView==stateTableView{
            stateLabel.textColor=UIColor.black
            stateLabel.text=stateList[indexPath.row]
            stateID=stateIDs[indexPath.row]
            stateTableView.isHidden=true
        }
        else
        {   positionLabel.textColor=UIColor.black
            positionLabel.text=selectPositionList[indexPath.row]
            selectPositionTableView.isHidden=true
        }
    }
    
    
    @IBAction func countrySelectAction(_ sender: UIButton) {
       /* countrySelection=1
        genderTableview.reloadData()
        if genderTableview.isHidden==true
        {
            genderTableview.isHidden=false
            stateTableView.isHidden=true
            selectPositionTableView.isHidden=true
        }
        else
        {
            genderTableview.isHidden=true
        }
 */
    }
    
    
    @IBAction func stateSelectAction(_ sender: UIButton) {
      /*  if stateList.count != 0
        {
            stateTableView.reloadData()
            if stateTableView.isHidden==true
            {
                stateTableView.isHidden=false
                selectPositionTableView.isHidden=true
                
                genderTableview.isHidden=true
            }
            else
            {
                stateTableView.isHidden=true
            }
        }
        else
        {
            let alert=UIAlertController(title: "Alert", message: "Select The Country", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
 */
    }
    
    
    @IBAction func citySelectAction(_ sender: UIButton) {
    }
    
    @IBAction func selectPositionAction(_ sender: UIButton) {
        if selectPositionTableView.isHidden==true
        {
            selectPositionTableView.isHidden=false
            stateTableView.isHidden=true
            genderTableview.isHidden=true
        }
        else
        {
            selectPositionTableView.isHidden=true
        }
    }
    
    
    @IBAction func submitButton(_ sender: UIButton) {
     /*   let valid=validateEmail(candidate: emailIDTextField.text!)
        if fullNameTextField.text?.isEmpty==true || fullNameTextField.text==""
        {let alert=UIAlertController(title: "Alert", message: "Enter Full Name", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
        else if dateOfBirthTextField.text?.isEmpty==true || dateOfBirthTextField.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Select Date Of Birth", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if countryLabel.text?.isEmpty==true || countryLabel.text=="" || countryLabel.text=="Select Country"
        {
            let alert=UIAlertController(title: "Alert", message: "Select the Country", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if stateLabel.text?.isEmpty==true || stateLabel.text=="" || stateLabel.text=="Select State"
        {
            let alert=UIAlertController(title: "Alert", message: "Select the State", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if enterTheCityTextField.text?.isEmpty==true || enterTheCityTextField.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The City", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if mobileNumberTextField.text?.isEmpty==true || mobileNumberTextField.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter the Mobile Number", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if mobileNumberTextField.text?.count != 10
        {
            let alert=UIAlertController(title: "Alert", message: "Mobile Number Should Be 10 digits", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if mobileNumberTextField.text?.count != 10
        {
            let alert=UIAlertController(title: "Alert", message: "Mobile Number Should Be 10 digits", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if emailIDTextField.text?.isEmpty==true || emailIDTextField.text==""
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The Email ID", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if valid == false
        {
            let alert=UIAlertController(title: "Alert", message: "Enter The Valid Email ID", preferredStyle: .alert)
            let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        else if sponserIDTextField.text?.isEmpty==false || sponserIDTextField.text != ""
        {
            let jeremyGif = UIImage.gifImageWithName("preloader")
            imageView = UIImageView(image: jeremyGif)
            
            imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 50 , y: (self.view.frame.size.height/2)-50, width: 100, height: 100)
            self.view.addSubview(imageView)
            self.view.isUserInteractionEnabled=false
            
            verifySponserID()
            selection=2
        }
        else if sponserIDTextField.text?.isEmpty==true || sponserIDTextField.text==""
        { sponserIDNew="0"
            let jeremyGif = UIImage.gifImageWithName("preloader")
            imageView = UIImageView(image: jeremyGif)
            
            imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 50 , y: (self.view.frame.size.height/2)-50, width: 100, height: 100)
            self.view.addSubview(imageView)
            self.view.isUserInteractionEnabled=false
            sendOTP()
            selection=3
        }
        else
        {
            
        }*/
        let parent=self.parent! as! EditProfile
        parent.moveToViewController(at: 1)
        
        
        
        
    }
    func getCountryList()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCountryList xmlns=\"http://tempuri.org/\"><SecurityKey>MLM@#4321</SecurityKey></GetCountryList></soap:Body></soap:Envelope>"
        let is_URL: String = "http://wservice.mlm.senoverp.com/Wservicemlm.asmx?"
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("wservice.mlm.senoverp.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetCountryList", forHTTPHeaderField: "SOAPAction")
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
                    let dummy:String=self.countryResult
                    let dummyArray=dummy.components(separatedBy: "^")
                    if dummyArray.count>1
                    {
                        for value in dummyArray
                        {
                            let dummyArray1=value.components(separatedBy: "~")
                            if dummyArray1.count==2
                            {
                                self.countryIDS.append(dummyArray1[0])
                                self.countryList.append(dummyArray1[1])
                            }
                            
                        }
                    }
                    self.imageView.isHidden=true
                    self.view.isUserInteractionEnabled=true
                }
            }
        })
        task.resume()
        
    }
    func getStateList()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetStateList xmlns=\"http://tempuri.org/\"><CountryID>\(countryID)</CountryID><SecurityKey>MLM@#4321</SecurityKey></GetStateList></soap:Body></soap:Envelope>"
        let is_URL: String = "http://wservice.mlm.senoverp.com/Wservicemlm.asmx?"
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("wservice.mlm.senoverp.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetStateList", forHTTPHeaderField: "SOAPAction")
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
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
                    let dummy:String=self.stateResult
                    let dummyArray=dummy.components(separatedBy: "^")
                    if dummyArray.count>1
                    {
                        for value in dummyArray
                        {
                            let dummyArray1=value.components(separatedBy: "~")
                            if dummyArray1.count==2
                            {
                                self.stateIDs.append(dummyArray1[0])
                                self.stateList.append(dummyArray1[1])
                            }
                            
                        }
                        
                        print(self.stateList)
                        DispatchQueue.main.async {
                            self.stateTableView.delegate=self
                            self.stateTableView.dataSource=self
                            self.stateTableViewHeight.constant=CGFloat(self.stateList.count*35)
                            self.stateTableView.reloadData()
                        }
                    }
                    else{
                        let dummy123=dummy.components(separatedBy: "~")
                        if dummy123.count==2
                        {
                            self.stateIDs.append(dummy123[0])
                            self.stateList.append(dummy123[1])
                        }
                        DispatchQueue.main.async {
                            self.stateTableView.delegate=self
                            self.stateTableView.dataSource=self
                            self.stateTableView.reloadData()
                            self.stateTableViewHeight.constant=CGFloat(self.stateList.count*35)
                            self.stateTableView.layoutIfNeeded()
                        }
                    }
                }
            }
        })
        task.resume()
        
    }
    func verifySponserID()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><VerifySponcer xmlns=\"http://tempuri.org/\"><SponcerID>\(sponserIDTextField.text!)</SponcerID><SecurityKey>MLM@#4321</SecurityKey></VerifySponcer></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/VerifySponcer", forHTTPHeaderField: "SOAPAction")
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
                    if self.sponserIDResult=="0"
                    {
                        self.imageView.isHidden=true
                        self.view.isUserInteractionEnabled=true
                        let alert = UIAlertController(title: "Alert", message: "Invalid SponserID", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        self.sponserIDNew=self.sponserIDTextField.text!
                        self.sendOTP()
                        self.selection=3
                    }
                }
                
            }
        })
        task.resume()
        
    }
    func sendOTP()
    {
        var mobileNumber:String=mobileNumberTextField.text!
        UserDefaults.standard.set(mobileNumber, forKey: "mobileNumber")
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SendOTP xmlns=\"http://tempuri.org/\"><number>\(mobileNumberTextField.text!)</number><SecurityKey>MLM@#4321</SecurityKey></SendOTP></soap:Body></soap:Envelope>"
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
                        let alert = UIAlertController(title: "Alert", message: "Mobile number already Exist. Plese Choose Another one", preferredStyle: .alert)
                        let action=UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        self.imageView.isHidden=true
                        self.view.isUserInteractionEnabled=true
                        var passData="\(self.fullNameTextField.text!)"+"^"+"\(self.dateOfBirthTextField.text!)"+"^"+"\(self.genderLabel.text!)"+"^"+"\(self.countryID)"+"^"+"\(self.countryLabel.text!)"+"^"+"\(self.stateID)"+"^"+"\(self.stateLabel.text!)"+"^"+"\(self.enterTheCityTextField.text!)"+"^"+"\(self.mobileNumberTextField.text!)"+"^"+"\(self.emailIDTextField.text!)"+"^"+"\(self.sponserIDNew)"+"^"+"\(self.positionLabel.text!)"
                        UserDefaults.standard.set(passData, forKey: "passData")
                        let st=UIStoryboard(name: "Main", bundle: nil)
                        let vc=st.instantiateViewController(withIdentifier: "OTP") as! UIViewController
                        self.present(vc, animated: true, completion: nil)
                        
                    }
                }
                
            }
        })
        task.resume()
        
    }
    
    var elementValue: String?
    var countryElementValue:String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetCountryListResult" {
            elementValue = String()
        }
        if elementName == "GetStateListResult" {
            countryElementValue = String()
        }
        if elementName == "VerifySponcerResult" {
            sponserIDValue = String()
        }
        if elementName == "SendOTPResult" {
            otpElementValue = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection == 0 {
            elementValue! += string
            countryResult=elementValue!
            //print(countryResult,"888")
        }
        if countryElementValue != nil && selection == 1 {
            countryElementValue! += string
            stateResult=countryElementValue!
            
        }
        if sponserIDValue != nil && selection == 2 {
            sponserIDValue += string
            sponserIDResult=sponserIDValue
            
        }
        if otpElementValue != nil && selection == 3 {
            otpElementValue += string
            otpResult=otpElementValue
            print(otpResult,"888")
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetCountryListResult" {
            elementValue = String()
            
        }
        if elementName == "GetStateListResult" {
            countryElementValue = String()
        }
        if elementName == "VerifySponcerResult" {
            sponserIDValue = String()
        }
        if elementName == "SendOTPResult" {
            otpElementValue = String()
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
}
