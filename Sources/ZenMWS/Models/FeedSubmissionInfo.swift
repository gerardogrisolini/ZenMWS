//
//  FeedSubmissionInfo.swift
//  mwsWebretail
//
//  Created by Gerardo Grisolini on 21/04/18.
//

import Foundation

public struct FeedSubmissionInfo {
    // SubmitFeed
    public var feedSubmissionId: String = ""
    public var feedProcessingStatus: String = ""
    
    // GetFeedSubmissionResult
    public var statusCode: String = ""
    public var errorDescription: String = ""
    public var messagesProcessed: Int = 0
    public var messagesSuccessful: Int = 0
    public var messagesWithError: Int = 0
    public var messagesWithWarning: Int = 0
    
    public mutating func error(text: String) {
        self.messagesWithError = 1
        self.errorDescription = text
    }
}
