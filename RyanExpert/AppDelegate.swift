//
//  AppDelegate.swift
//  RyanExpert
//
//  Created by Keyur Akbari on 03/08/20.
//  Copyright © 2020 Keyur Akbari. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import IQKeyboardManagerSwift
import MFSideMenu
import Firebase
import FirebaseMessaging
import FirebaseInstanceID

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var activityLoader : NVActivityIndicatorView!
    var customTabbarVc : CustomTabBarController!
    var container : MFSideMenuContainerViewController = MFSideMenuContainerViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //IQKeyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        
        window?.backgroundColor = WhiteColor
        
        FirebaseApp.configure()
        
        //Push Notification
        registerPushNotification(application)
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        if isUserLogin() {
            AppModel.shared.currentUser = getLoginUserData()
            navigateToDashBoard()
        }
        return true
    }

    //MARK:- Share Appdelegate
    func storyboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func sharedDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK:- Tab Bar
    func showTabBar() {
        if customTabbarVc != nil {
            customTabbarVc.setTabBarHidden(tabBarHidden: false)
        }
    }
    
    func hideTabBar() {
        if customTabbarVc != nil {
            customTabbarVc.setTabBarHidden(tabBarHidden: true)
        }
    }
    
    //MARK:- Navigation
    func navigateToDashBoard() {
        let rootVC: MFSideMenuContainerViewController = STORYBOARD.HOME.instantiateViewController(withIdentifier: "MFSideMenuContainerViewController") as! MFSideMenuContainerViewController
        container = rootVC
        
        customTabbarVc = (STORYBOARD.HOME.instantiateViewController(withIdentifier: "CustomTabBarController") as! CustomTabBarController)
        if #available(iOS 9.0, *) {
            let leftSideMenuVC: UIViewController = STORYBOARD.HOME.instantiateViewController(withIdentifier: "SideMenuVC")
            container.menuWidth = 290
            container.panMode = MFSideMenuPanModeSideMenu
            container.menuSlideAnimationEnabled = true
            container.leftMenuViewController = leftSideMenuVC
            container.centerViewController = customTabbarVc
            
            container.view.layer.masksToBounds = false
            container.view.layer.shadowOffset = CGSize(width: 10, height: 10)
            container.view.layer.shadowOpacity = 0.5
            container.view.layer.shadowRadius = 5
            container.view.layer.shadowColor = UIColor.clear.cgColor
            let rootNavigatioVC : UINavigationController = self.window?.rootViewController
                as! UINavigationController
            rootNavigatioVC.pushViewController(container, animated: false)
        }
    }
    
    func navigateToLogin()
    {
        let navigationVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SelectLoginVCNav") as! UINavigationController
        UIApplication.shared.keyWindow?.rootViewController = navigationVC
    }
    
    func navigateToLogout()
    {
        removeUserDefaultValues()
        setNotFirstTime(true)
        AppModel.shared.resetAllModel()
        navigateToLogin()
    }
    
    //MARK:- Notification
    func registerPushNotification(_ application: UIApplication)
    {
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        printData("Notification registered")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        printData("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    //Get Push Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        //application.applicationIconBadgeNumber = Int((userInfo["aps"] as! [String : Any])["badge"] as! String)!
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func getFCMToken() -> String
    {
        return Messaging.messaging().fcmToken!
    }
    
    //MARK:- AppDelegate Method
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

//MARK:- Loader
extension AppDelegate {
    func showLoader()
    {
        removeLoader()
        window?.isUserInteractionEnabled = false
        activityLoader = NVActivityIndicatorView(frame: CGRect(x: ((window?.frame.size.width)!-50)/2, y: ((window?.frame.size.height)!-50)/2, width: 50, height: 50))
        activityLoader.type = .ballSpinFadeLoader
        activityLoader.color = GreenColor
        window?.addSubview(activityLoader)
        activityLoader.startAnimating()
    }
    
    func removeLoader()
    {
        window?.isUserInteractionEnabled = true
        if activityLoader == nil
        {
            return
        }
        activityLoader.stopAnimating()
        activityLoader.removeFromSuperview()
        activityLoader = nil
    }
}

//MARK:- Get Top ViewController
extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

extension AppDelegate {
    
    func serviceCallToGetData() {
        APIManager.shared.serviceCallToGetCmsData()
        APIManager.shared.serviceCallToGetProfile()
        APIManager.shared.serviceCallToGetPaymentDetails { (dict) in
            if let bankdetails = dict["bankdetails"] as? [String : Any] {
                setBankDetail(bankdetails)
            }
        }
    }
    
    func serviceCallToUpdateFcmToken() {
        if getFCMToken() != "" {
            APIManager.shared.serviceCallToUpdateFcmToken(["device_id" : getFCMToken()]) {
                
            }
        }
    }
    
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        //printData("Firebase registration token: \(fcmToken)")
        if getPushToken() == "" {
            setPushToken(fcmToken)
        }
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        //printData("Received data message: \(remoteMessage.appData)")
    }
}

// MARK:- Push Notification
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        _ = notification.request.content.userInfo
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if UIApplication.shared.applicationState == .inactive {
            _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(delayForNotification(tempTimer:)), userInfo: userInfo, repeats: false)
        } else {
            notificationHandler(userInfo as! [String : Any])
        }
        completionHandler()
    }
    
    @objc func delayForNotification(tempTimer:Timer) {
        notificationHandler(tempTimer.userInfo as! [String : Any])
    }
    
    //Redirect to screen
    func notificationHandler(_ dict : [String : Any]) {
        if !isUserLogin(){
            return
        }
        //NotificationCenter.default.post(name: NSNotification.Name.init(NOTIFICATION.NOTIFICATION_REDIRECTION), object: nil)
    }
}
