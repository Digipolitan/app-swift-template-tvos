//
//  UIView+Nib.swift
//  AppSwiftTemplate-tvOS
//
//  Created by Benoit BRIATTE on 09/11/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

extension UIView {
    public class func fromNib<V: UIView>(_ nibName: String, nibBundle: Bundle? = nil, owner: Any? = nil) -> V {
        guard let view = self.nib(name: nibName, bundle: nibBundle).instantiate(withOwner: owner, options: nil)[0] as? V else {
            fatalError("Cannot instanciate \(V.self) from nib \(nibName)")
        }
        return view
    }

    public class func nib(name: String? = nil, bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: name ?? String(describing: self), bundle: bundle)
    }
}
