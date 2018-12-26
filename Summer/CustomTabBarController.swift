//
//  CustomTabBarController.swift
//  Summer
//
//  Created by Artesia Ko on 12/24/18.
//  Copyright © 2018 Yanlam. All rights reserved.
//

import Foundation
import UIKit

protocol showChat: class {
    func presentChat(chatController: ChatController)
}
class CustomTabBarController: UITabBarController {
    
    let co_tabBarBackground: UIColor = .white
    let co_tabBarTint: UIColor = UIColor(red: 133/255, green: 226/255, blue: 209/255, alpha: 1)
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
        nav_home.tabBarItem.image = UIImage(named: "home")
        
        /*********************     SETTINGS VIEW CONTROLLER    ********************/
        profileController.navigationItem.title = "Profile"
        let nav_profile = UINavigationController(rootViewController: profileController)
        nav_profile.title = "Profile"
        nav_profile.tabBarItem.image = UIImage(named: "profile")
  
        /*********************     Set ViewControllers for TabBarController    ********************/
        viewControllers = [nav_home, nav_profile]
    }
}

extension CustomTabBarController: showChat {
    func presentChat(chatController: ChatController) {
        self.nav_home.present(chatController, animated: true, completion: nil)
    }
}
