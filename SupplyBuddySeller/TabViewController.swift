//
//  TabViewController.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
     //   self.tabBarController?.navigationController?.navigationBar.isHidden = false


        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       // self.tabBarController?.navigationController?.navigationBar.isHidden = false
        
        
        super.viewWillAppear(animated)
        let tabBarItems = tabBar.items! as [UITabBarItem]
        
        tabBarItems[0].image = UIImage(named: "tab1")
        tabBarItems[1].image = UIImage(named: "tab2")
        tabBarItems[2].image = UIImage(named: "tab3")
        tabBarItems[3].image = UIImage(named: "tab4")
        tabBarItems[4].image = UIImage(named: "tab5")

    }
    override func viewWillDisappear(_ animated: Bool) {
      //  self.tabBarController?.navigationController?.navigationBar.isHidden = false//
        
        
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }

   
}
