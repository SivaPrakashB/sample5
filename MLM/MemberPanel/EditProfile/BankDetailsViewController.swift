//
//  BankDetailsViewController.swift
//  MLM
//
//  Created by Apple on 13/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class BankDetailsViewController: UIViewController,IndicatorInfoProvider,UITextFieldDelegate {
    var activeTextField=UITextField()
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "BANK DETAILS")
        
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(_ sender: UIButton) {
        let parentViewController = self.parent! as! EditProfile
        parentViewController.moveToViewController(at: 3)
    }
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField=textField
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        activeTextField.resignFirstResponder()
        return true
    }
   
  @objc func keyboardDidShow(notification: Notification) {
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let parent=self.parent! as! EditProfile
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
    var array1 = [2.1, 2.2, 2.5, 3.0, 4.2, 2]
    
    var array2 = array1.sort(){ $0 > $1}
    
   print(array2)
    
        
        
    }
    
     @objc func keyboardWillHide(notification: Notification) {
        let parent=self.parent! as! EditProfile
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
