//
//  Loader.swift
//  AppSwiftTemplate-tvOS
//
//  Created by Benoit BRIATTE on 08/11/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit
import Monet

@objc public protocol Animatable {
    func startAnimating()
    func stopAnimating()
}

extension UIActivityIndicatorView: Animatable { }
extension UIImageView: Animatable { }

public protocol LoaderViewDelegate: class {
    func loadViewCancelButtonClicked(_ loaderView: LoaderView)
    func loadViewReloadButtonClicked(_ loaderView: LoaderView)
}

@IBDesignable
public class LoaderView: UIView {

    @IBOutlet public var loadingLabel: UILabel!
    @IBOutlet public var contentView: UIView?
    @IBOutlet public var errorLabel: UILabel?
    @IBOutlet public var animatable: (UIView & Animatable)?
    @IBOutlet public var cancelButton: UIButton?
    @IBOutlet public var reloadButton: UIButton?

    public weak var delegate: LoaderViewDelegate?

    @IBInspectable public var showsCancelButton: Bool = false
    @IBInspectable public var showsReloadButton: Bool = true
    public private(set) var isLoading: Bool = false

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if let superview = newSuperview {
            var action = self.cancelButton?.actions(forTarget: self, forControlEvent: .touchUpInside)?.contains("touchCancel")
            if action == nil || action! == false {
                self.cancelButton?.addTarget(self, action: #selector(touchCancel), for: .touchUpInside)
            }
            action = self.reloadButton?.actions(forTarget: self, forControlEvent: .touchUpInside)?.contains("touchReload")
            if action == nil || action! == false {
                self.reloadButton?.addTarget(self, action: #selector(touchReload), for: .touchUpInside)
            }
            self.translatesAutoresizingMaskIntoConstraints = false
            self.frame = superview.bounds
        }
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let superview = self.superview else {
            return
        }
        NSLayoutConstraint.activate(self.constraintMatch(parent: superview))
    }

    public func setupUI(theme: Theme) { }

    public func load(message: String, in parent: UIView) {
        guard !self.isLoading else {
            return
        }
        self.isLoading = true
        self.loadingLabel.text = message
        self.animatable?.startAnimating()
        self.animatable?.isHidden = false
        self.errorLabel?.isHidden = true
        self.loadingLabel?.isHidden = false
        self.reloadButton?.isHidden = true
        self.cancelButton?.isHidden = !self.showsCancelButton
        parent.addSubview(self)
    }

    public func error(message: String) {
        guard self.isLoading else {
            return
        }
        self.isLoading = false
        self.errorLabel?.text = message
        self.animatable?.stopAnimating()
        self.animatable?.isHidden = true
        self.loadingLabel?.isHidden = true
        self.errorLabel?.isHidden = false
        self.cancelButton?.isHidden = true
        self.reloadButton?.isHidden = !self.showsReloadButton
    }

    public func dismiss() {
        self.isLoading = false
        self.animatable?.stopAnimating()
        self.removeFromSuperview()
    }

    @objc private func touchCancel() {
        self.delegate?.loadViewCancelButtonClicked(self)
    }

    @objc private func touchReload() {
        self.delegate?.loadViewReloadButtonClicked(self)
    }
}

extension LoaderViewDelegate {
    public func loadViewCancelButtonClicked(_ loaderView: LoaderView) { }
    public func loadViewReloadButtonClicked(_ loaderView: LoaderView) { }
}
