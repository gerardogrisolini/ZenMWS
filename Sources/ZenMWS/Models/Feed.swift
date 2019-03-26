//
//  Feed.swift
//  mwsWebretail
//
//  Created by Gerardo Grisolini on 21/04/18.
//

public protocol Feed {
    func feedType() -> String
    func xml(compact: Bool) -> String
}

public struct EmptyFeed : Feed {
    public func feedType() -> String { return "" }
    public func xml(compact: Bool) -> String { return "" }
}
