//
//  UploadPhotoViewController.swift
//  MLM
//
//  Created by Apple on 13/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class UploadPhotoViewController: UIViewController,IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "UPLOAD PHOTO")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
 print("First View3")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    @IBAction func submit(_ sender: UIButton) {
        let parent=self.parent! as! EditProfile
        parent.moveToViewController(at: 0)
    }
    
}
