//
//  ServiceError.swift
//  Domain
//
//  Created by Benoit BRIATTE on 01/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import Foundation

public class ServiceError: Error {

    public let error: Error?
    public let reason: String?
    public let code: ServiceCode

    public init(code: ServiceCode, error: Error? = nil, reason: String? = nil) {
        self.code = code
        self.error = error
        self.reason = reason
    }
}
