import Foundation

public struct InventoryFeed : Feed, Codable {
    
    let purgeAndReplace : Bool
	let messages : [InventoryMessage]

    public init(
        purgeAndReplace: Bool,
        messages: [InventoryMessage]
    ) {
        self.purgeAndReplace = purgeAndReplace
        self.messages = messages
    }
    
    public func feedType() -> String { return "_POST_INVENTORY_AVAILABILITY_DATA_" }

    public func xml(compact: Bool) -> String {
 
        let doc = ZenMWS.newDocument()
        let envelope = doc.root
        
        envelope.addChild(name: "MessageType", value: "Inventory")
        envelope.addChild(name: "PurgeAndReplace", value: purgeAndReplace.description)
        
        for (index, message) in self.messages.enumerated() {
            let m = envelope.addChild(name: "Message")
            m.addChild(name: "MessageID", value: "\(index + 1)")
            m.addChild(name: "OperationType", value: message.operationType.rawValue)
            
            let p = m.addChild(name: "Inventory")
            p.addChild(name: "SKU", value: message.inventory.sku)
            p.addChild(name: "Quantity", value: message.inventory.quantity.description)
        }
        
        return compact ? doc.xmlCompact : doc.xml
/*
        var xml = """
  <MessageType>Inventory</MessageType>
  <PurgeAndReplace>\(purgeAndReplace)</PurgeAndReplace>\n
"""
        for (index, message) in self.messages.enumerated() {
            xml += """
  <Message>
    <MessageID>\(index + 1)</MessageID>
    <OperationType>\(message.operationType.rawValue)</OperationType>
    <Inventory>
      <SKU>\(message.inventory.sku)</SKU>
      <Quantity>\(message.inventory.quantity)</Quantity>
    </Inventory>
  </Message>\n
"""
        }
        return xml
*/
    }
}
