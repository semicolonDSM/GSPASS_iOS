//
//  AppDelegate.swift
//  GSPASS
//
//  Created by 김수완 on 2021/05/20.
//

import UIKit
import RxSwift
import KeychainSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()
    let keychain = KeychainSwift()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        HTTPClient.shared.networking(.tokenRefresh, TokenModel.self).subscribe(onSuccess: { token in
            self.keychain.set(token.access_token, forKey: "ACCESS-TOKEN")
            self.keychain.set(token.refresh_token, forKey: "REFRESH-TOKEN")
            self.setRootViewController("Main", "MainNavigationController")
        }, onFailure: { _ in
            self.setRootViewController("Auth", "LoginViewController")
        })
        .disposed(by: disposeBag)

        return true
    }
    
    private func setRootViewController(_ storyboardName: String, _ viewControllerIdentifier: String){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }

}

