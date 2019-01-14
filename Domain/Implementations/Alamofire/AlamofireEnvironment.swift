//
//  AlamofireEnvironment.swift
//  Domain
//
//  Created by Benoit BRIATTE on 01/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import Foundation
import AlamofireLogging
import RuntimeEnvironment

struct AlamofireEnvironment {

    public enum Consts {
        public static let host: String = "http://localhost"
        public static let basePath: String = ""
        public static let logLevel: LogLevel = .none
    }

    public enum Keys {
        public static let root: String = "alamofire"
        public static let logLevel: String = "log_level"
        public static let host: String = "host"
        public static let port: String = "port"
        public static let basePath: String = "base_path"
    }

    public let logLevel: LogLevel
    public let host: String
    public let port: Int?
    public let basePath: String

    public static let current = AlamofireEnvironment()

    private init() {
        guard let alamofire = RuntimeEnvironment.shared[Keys.root] as? [String: Any] else {
            fatalError("Missing Alamofire environement")
        }
        let logLevel = alamofire[Keys.logLevel] as? Int ?? 0
        self.logLevel = LogLevel(rawValue: logLevel) ?? Consts.logLevel
        self.host = alamofire[Keys.host] as? String ?? Consts.host
        self.port = alamofire[Keys.port] as? Int
        self.basePath = alamofire[Keys.basePath] as? String ?? Consts.basePath
    }
}

extension AlamofireEnvironment {

    public var baseUrl: String {
        var url = self.host
        if let port = self.port {
            url += ":\(port)"
        }
        url += self.basePath
        return url
    }

    public func url(with childPath: String) -> String {
        return "\(self.baseUrl)\(childPath)"
    }
}
