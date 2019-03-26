//
//  Config.swift
//  mwsWebretail
//
//  Created by Gerardo Grisolini on 18/04/18.
//

public struct Config : Codable {
    let version = "2009-01-01"
    var endpoint = "mws-eu.amazonservices.com"
    var marketplaceId = ""
    var sellerId = ""
    var accessKey = ""
    var secretKey = ""
    var authToken = ""
    var userAgent = ""
    
    public init(
        endpoint: String,
        marketplaceId: String,
        sellerId: String,
        accessKey: String,
        secretKey: String,
        authToken: String,
        userAgent: String
    ) {
        self.endpoint = endpoint
        self.marketplaceId = marketplaceId
        self.sellerId = sellerId
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.authToken = authToken
        self.userAgent = userAgent
    }
}
