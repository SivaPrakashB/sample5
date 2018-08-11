//
//  ViewController.swift
//  MLM
//
//  Created by Narayan on 6/14/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate,XMLParserDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var leading: NSLayoutConstraint!
    var menu=false
    var name=["Siva","Prakash"]
    var GetBannersForAndrodResult=String()
    var firstStringsValues=[String]()
    var count1=Int()
    var titleNames=[String]()
    var links=[String]()
    var imageLinks=[String]()
    var x=1
    private var abc=String()
    
    @IBOutlet weak var pagecontrols: UIPageControl!
    @IBOutlet weak var slideCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor=UIColor.lightGray
        let tap=UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissView))
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
        getbanners()
    
    }

    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func SlideView(_ sender: UIBarButtonItem) {
        if menu==true
        {
            menu=false
            UIView.animate(withDuration: 0.50, delay: 0, options: .curveEaseIn, animations: {
               self.leading.constant = -200
                self.view.layoutIfNeeded()
            }, completion: nil)
           
            abc=""
        }
        else
        {
            menu=true
            UIView.animate(withDuration: 0.50, delay: 0, options: .curveEaseOut, animations: {
                self.leading.constant = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
           
           
        }
    }
   @objc func dismissView()
    {
        UIView.animate(withDuration: 0.50, delay: 0, options: .curveEaseIn, animations: {
            self.leading.constant = -200
            self.view.layoutIfNeeded()
        }, completion: nil)
        menu=false
        
        
    }
    
    func getbanners()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetBannersForAndrod xmlns=\"http://tempuri.org/\"><SecurityKey>#111000$</SecurityKey></GetBannersForAndrod></soap:Body></soap:Envelope>"
        let is_URL: String = "http://admin.khatabahi.com/KhataBahiService.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
      lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("admin.khatabahi.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetBannersForAndrod", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            if data != nil
            {
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            
                DispatchQueue.main.async {
                    
                    let GetBannersForAndrodResult1=self.GetBannersForAndrodResult
                    self.firstStringsValues=GetBannersForAndrodResult1.components(separatedBy:"^")
                    //  print(firstStringsValues)
                    self.count1=self.firstStringsValues.count
                    print(self.count1,"bvsp count")
                    if self.count1 > 3
                    {
                        for index in 0..<self.count1
                        {//print(firstStringsValues[index])
                            var value:String=self.firstStringsValues[index]
                            print(value)
                            
                            var titleLinkImage=value.components(separatedBy: "~")
                            print(titleLinkImage)
                            
                            self.titleNames.append(titleLinkImage[0])
                            self.links.append(titleLinkImage[1])
                            self.imageLinks.append(titleLinkImage[2])
                            
                        }
                        
                        print(self.titleNames.count,"**********")
                        print(self.links.count,"+++++++++++")
                        print(self.imageLinks.count,"------------")
                        DispatchQueue.main.async {
                            self.pagecontrols.numberOfPages=self.count1
                            self.slideCollectionView.reloadData()
                            self.setTimer()
                            
                        }
                    }
                    
                }
        
            }
            //XMLparser.shouldResolveExternalEntities = true
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
            }
            
        })
        task.resume()
        
    }
    
    
    
    var elementValue: String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetBannersForAndrodResult" {
            elementValue = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil {
            elementValue! += string
            GetBannersForAndrodResult=elementValue!
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetBannersForAndrodResult" {
            elementValue = String()
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    func setTimer() {
        let _ = Timer.scheduledTimer(timeInterval:3, target: self, selector: #selector(ViewController.autoScroll), userInfo: nil, repeats: true)
    }
    @objc func autoScroll() {
        self.pagecontrols.currentPage = x
        if self.x < count1{
            
            
            let indexPath = IndexPath(item: x, section: 0)
            self.slideCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.x = self.x + 1
        } else {
            self.x = 0
            self.slideCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
            
       // self.slideCollectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
        }
    }
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if (context.nextFocusedItem != nil) {
            slideCollectionView.scrollToItem(at: context.nextFocusedItem as! IndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            return titleNames.count
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            var cell = slideCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SlideCollectionViewCell
            
            var smallImage:String=imageLinks[indexPath.row]
            DispatchQueue.global().async {
                let url = URL(string: "\(smallImage)")
                
                let imageData = try? Data(contentsOf: url!)
                
                DispatchQueue.main.sync {
                    if imageData != nil
                    {
                        cell.image1.image = UIImage(data: imageData!)
                    }
                    
                }
        }
    return cell
     
        
    }
    
    
    
    
}
extension ViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width=CGFloat()
        var height=CGFloat()
      /*  if collectionView==slideCollectionView
        {
         width=self.slideCollectionView.bounds.width
         height=self.slideCollectionView.bounds.height
        }*/
        
        width=self.view.bounds.width
        height=self.slideCollectionView.bounds.height
        return CGSize(width: width, height: height)
        
    }
}
