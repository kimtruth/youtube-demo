//
//  AppDelegate.swift
//  youtube demo
//
//  Created by truth on 2019. 2. 2..
//  Copyright © 2019년 kimtruth. All rights reserved.
//

import UIKit

import CGFloatLiteral
import SnapKit
import Then

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    let layout = UICollectionViewFlowLayout()
    let homeController = HomeController(collectionViewLayout: layout)
    let navigationController = UINavigationController(rootViewController: homeController)
    
    navigationController.navigationBar.barStyle = .black
    navigationController.navigationBar.barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
    navigationController.navigationBar.isTranslucent = false
    navigationController.navigationBar.shadowImage = UIImage()
    navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
    
    window.makeKeyAndVisible()
    window.rootViewController = navigationController
    
    self.window = window
    
    let statusBarBackgroundView = UIView().then {
      $0.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
    }
    let height = application.statusBarFrame.height
    
    self.window?.addSubview(statusBarBackgroundView)
    statusBarBackgroundView.snp.makeConstraints { (make) in
      make.top.left.right.equalToSuperview()
      make.height.equalTo(height)
    }
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

