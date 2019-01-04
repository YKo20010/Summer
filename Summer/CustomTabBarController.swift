//
//  CustomTabBarController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    let co_tabBarBackground: UIColor = .white
    let co_tabBarTint: UIColor = Static.lightAqua
    var nav_home: UINavigationController!
    
    var homeController: ViewController! = ViewController()
    var profileController: ProfileController! = ProfileController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*********************     CUSTOMIZE TAB BAR APPEARANCE    ********************/
        view.isOpaque = true
        self.tabBar.barTintColor = co_tabBarBackground
        self.tabBar.tintColor = co_tabBarTint
        self.tabBar.isTranslucent = false
        self.tabBar.shadowImage = UIImage()
        
        /*********************     HOME VIEW CONTROLLER    ********************/
        homeController.navigationItem.title = "Messages"
        nav_home = UINavigationController(rootViewController: homeController)
        nav_home.title = "Home"
        nav_home.tabBarItem.image = UIImage(named: "iconChat")
        
        /*********************     SETTINGS VIEW CONTROLLER    ********************/
        profileController.navigationItem.title = " "
        let nav_profile = UINavigationController(rootViewController: profileController)
        nav_profile.title = "Profile"
        nav_profile.tabBarItem.image = UIImage(named: "iconProfile")
  
        /*********************     Set ViewControllers for TabBarController    ********************/
        viewControllers = [nav_home, nav_profile]
    }
}
