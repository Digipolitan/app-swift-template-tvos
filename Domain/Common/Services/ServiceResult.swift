//
//  ServiceResult.swift
//  Domain
//
//  Created by Benoit BRIATTE on 01/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import Foundation

public class ServiceResult<Response> {

    public let response: Response?
    public let error: ServiceError?

    public init(response: Response) {
        self.response = response
        self.error = nil
    }

    public init(error: ServiceError) {
        self.error = error
        self.response = nil
    }
}
