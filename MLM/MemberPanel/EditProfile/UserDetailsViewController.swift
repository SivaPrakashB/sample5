//
//  UserDetailsViewController.swift
//  MLM
//
//  Created by Apple on 13/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class UserDetailsViewController: UIViewController,IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "USER DETAILS")
    }
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
   
    override func viewDidLoad() {
        super.viewDidLoad()
         print("First View1")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let parentViewController = self.parent! as! EditProfile
        parentViewController.moveToViewController(at: 2)
    }
    
}
