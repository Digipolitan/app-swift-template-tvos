//
//  LoaderView+ServiceError.swift
//  AppSwiftTemplate-tvOS
//
//  Created by Benoit BRIATTE on 09/11/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import Foundation
import Domain

extension LoaderView {

    public func error(_ serviceError: ServiceError) {
        self.error(message: serviceError.reason ?? self.localizedDescription(serviceError))
    }

    private func localizedDescription(_ serviceError: ServiceError) -> String {
        switch serviceError.code {
        case .badRequest:
            return "loader.errors.service.bad_request".localized()
        case .communication:
            return "loader.errors.service.communication".localized()
        default:
            return "loader.errors.service.unknown".localized()
        }
    }
}
