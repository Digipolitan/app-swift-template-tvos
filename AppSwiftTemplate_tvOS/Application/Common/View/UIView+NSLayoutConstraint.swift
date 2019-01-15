//
//  UIView+NSLayoutConstraint.swift
//  AppSwiftTemplate_tvOS
//
//  Created by Benoit BRIATTE on 03/11/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

public extension UIView {

    public func constraintMatch(parent: UIView, horizontally: Bool = true, vertically: Bool = true) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if horizontally {
            constraints.append(self.leftAnchor.constraint(equalTo: parent.leftAnchor))
            constraints.append(self.rightAnchor.constraint(equalTo: parent.rightAnchor))
        }
        if vertically {
            constraints.append(self.topAnchor.constraint(equalTo: parent.topAnchor))
            constraints.append(self.bottomAnchor.constraint(equalTo: parent.bottomAnchor))
        }
        return constraints
    }

}
