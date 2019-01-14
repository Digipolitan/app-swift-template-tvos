//
//  BaseViewController.swift
//  AppSwiftTemplate-tvOS
//
//  Created by Benoit BRIATTE on 06/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit
import Monet
import SessionKit

open class BaseViewController: UIViewController {

    public lazy var loaderView: LoaderView = {
        let loader: LoaderView = .fromNib("BasicLoaderView")
        loader.setupUI(theme: self.theme)
        return loader
    }()

    public var theme: Theme {
        return ThemeManager.shared.current
    }

    public var session: Session? {
        return Session.restore()
    }

    open func setupUI(theme: Theme) {
        self.view.setAppearance(theme.scene)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI(theme: self.theme)
    }

    public func addChildViewController(_ childController: UIViewController, to parent: UIView) {
        childController.view.frame = parent.bounds
        childController.view.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(childController.view)
        NSLayoutConstraint.activate(childController.view.constraintMatch(parent: parent))
        self.addChild(childController)
    }
}
