//
//  RequestFeed.swift
//  mwsWebretail
//
//  Created by Gerardo Grisolini on 21/04/18.
//

import Foundation

public class RequestFeed {

    public var requestId: Int = 0
    public var requestParentId: Int = 0
    public var requestSku: String = ""
    public var requestFeed : Feed = EmptyFeed()
    
    public var requestSubmissionId: String = ""
    public var requestCreatedAt: Int = Int.now()
    public var requestSubmittedAt: Int = 0
    public var requestCompletedAt: Int = 0
    
    public var messagesProcessed: Int = 0
    public var messagesSuccessful: Int = 0
    public var messagesWithError: Int = 0
    public var messagesWithWarning: Int = 0
    public var errorDescription: String = ""

    public init(sku: String, feed: Feed, id: Int = 0, parentId: Int = 0) {
        self.requestId = id
        self.requestParentId = parentId
        self.requestSku = sku
        self.requestFeed = feed
    }
}
