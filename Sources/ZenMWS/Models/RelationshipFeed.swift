//
//  RelationshipFeed.swift
//  mwsWebretail
//
//  Created by Gerardo Grisolini on 05/05/18.
//

import Foundation

public struct RelationshipFeed : Feed, Codable {
    
    let purgeAndReplace : Bool
	let messages : [RelationshipMessage]

    public init(
        purgeAndReplace: Bool,
        messages: [RelationshipMessage]
    ) {
        self.purgeAndReplace = purgeAndReplace
        self.messages = messages
    }
    
    public func feedType() -> String { return "_POST_PRODUCT_RELATIONSHIP_DATA_" }

    public func xml(compact: Bool) -> String {
        
        let doc = ZenMWS.newDocument()
        let envelope = doc.root
        
        envelope.addChild(name: "MessageType", value: "Relationship")
        envelope.addChild(name: "PurgeAndReplace", value: purgeAndReplace.description)
        
        for (index, message) in self.messages.enumerated() {
            let m = envelope.addChild(name: "Message")
            m.addChild(name: "MessageID", value: "\(index + 1)")
            m.addChild(name: "OperationType", value: message.operationType.rawValue)
            
            let p = m.addChild(name: "Relationship")
            p.addChild(name: "ParentSKU", value: message.relationship.parentSKU)
            
            for relation in message.relationship.relation {
                let r = p.addChild(name: "Relation")
                r.addChild(name: "SKU", value: relation.sku)
                r.addChild(name: "Type", value: relation.type.rawValue)
            }
        }
        
        return compact ? doc.xmlCompact : doc.xml
/*
        var xml = """
  <MessageType>Relationship</MessageType>
  <PurgeAndReplace>\(purgeAndReplace)</PurgeAndReplace>\n
"""
        for (index, message) in self.messages.enumerated() {
            xml += """
  <Message>
    <MessageID>\(index + 1)</MessageID>
    <OperationType>\(message.operationType.rawValue)</OperationType>
    <Relationship>
      <ParentSKU>\(message.relationship.parentSKU)</ParentSKU>\n
"""
            message.relationship.relation.forEach { (relation) in
                xml += "<Relation><SKU>\(relation.sku)</SKU><Type>\(relation.type.rawValue)</Type></Relation>"
            }
            xml += """
\n    </Relationship>
  </Message>\n
"""
        }
        
        return xml
*/
    }
}
