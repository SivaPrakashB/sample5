//
//  MyProfileParentViewController.swift
//  MLM
//
//  Created by Apple on 14/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

//
//  EditProfile.swift
//  MLM
//
//  Created by Apple on 13/07/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MyProfileParentViewController: ButtonBarPagerTabStripViewController{
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)

  
    
    override func viewDidLoad() {
        // change selected bar color
       
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 9)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
     changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
       
        super.viewDidLoad()
      
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
 override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProfileBankDetails")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProfileUserDetails")
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProfileSecurityDoacuments")
        let child_4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyProfileUploadPic")
    
        return [child_1,child_2,child_3,child_4]
        
    }
    
  /* override func canMoveTo(index: Int) -> Bool {
        return currentIndex != index && viewControllers.count > index
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        if indexWasChanged && toIndex > -1 && toIndex < viewControllers.count {
            
            
            
            print("New index: \(toIndex)")
        }
    }
   
    */
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false
    }
}
