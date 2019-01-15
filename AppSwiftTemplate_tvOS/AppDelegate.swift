//
//  AppDelegate.swift
//  AppSwiftTemplate_tvOS
//
//  Created by Benoit BRIATTE on 14/01/2019.
//  Copyright © 2019 Digipolitan. All rights reserved.
//

import UIKit
import RuntimeEnvironment
import DependencyInjector
import Domain
import SplashKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.bootstrap()

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = SplashNavigationController.newInstance(splashViewControllers: DefaultSplashViewController(nibName: "AppDefaultSplashViewController", bundle: nil)) { [weak self] _ in
            guard let target = self,
                let window = target.window else {
                    return
            }
            UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: {
                UIView.setAnimationsEnabled(false)
                window.rootViewController = UINavigationController(rootViewController: HomeViewController.newInstance())
                UIView.setAnimationsEnabled(true)
            }, completion: nil)
        }
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}

extension AppDelegate {
    fileprivate func bootstrap() {
        do {
            try self.setupEnv()
            self.setupDependencies()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    private func setupEnv() throws {
        let env = RuntimeEnvironment.shared
        let mode = env.mode.rawValue
        guard let bundle = Bundle.allFrameworks.first(where: { $0.bundlePath.hasSuffix("Domain.framework") }) else {
            fatalError("Missing Domain bundle")
        }
        try env.setFile("domain.\(mode)", format: .json, bundle: bundle)
        try env.setFile("app.\(mode)", format: .json)
    }

    private func setupDependencies() {
        let injector = Injector.default
        injector.register(module: ModelsModule.shared, with: "Models")
        injector.register(module: AlamofireModule.shared, with: "Alamofire")
    }
}
