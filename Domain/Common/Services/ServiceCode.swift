//
//  ServiceCode.swift
//  Domain
//
//  Created by Benoit BRIATTE on 01/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import Foundation

public enum ServiceCode: Int {
    case unknown
    case badRequest
    case malformatedResponse
    case unauthorized
    case forbidden
    case communication
    case conflict
    case unprocessable
}
