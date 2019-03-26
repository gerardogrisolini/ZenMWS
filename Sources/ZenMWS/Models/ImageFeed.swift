import Foundation

public struct ImageFeed : Feed, Codable {
    
	let purgeAndReplace : Bool
	let messages : [ImageMessage]

    public init(
        purgeAndReplace: Bool,
        messages: [ImageMessage]
    ) {
        self.purgeAndReplace = purgeAndReplace
        self.messages = messages
    }

    public func feedType() -> String { return "_POST_PRODUCT_IMAGE_DATA_" }

    public func xml(compact: Bool) -> String {
        
        let doc = ZenMWS.newDocument()
        let envelope = doc.root
        
        envelope.addChild(name: "MessageType", value: "ProductImage")
        envelope.addChild(name: "PurgeAndReplace", value: purgeAndReplace.description)
        
        for (index, message) in self.messages.enumerated() {
            let m = envelope.addChild(name: "Message")
            m.addChild(name: "MessageID", value: "\(index + 1)")
            m.addChild(name: "OperationType", value: message.operationType.rawValue)
            
            let p = m.addChild(name: "ProductImage")
            p.addChild(name: "SKU", value: message.productImage.sku)
            p.addChild(name: "ImageType", value: message.productImage.imageType.rawValue)
            p.addChild(name: "ImageLocation", value: message.productImage.imageLocation)
        }
        
        return compact ? doc.xmlCompact : doc.xml
/*
    var xml = """
  <MessageType>ProductImage</MessageType>
  <PurgeAndReplace>\(purgeAndReplace)</PurgeAndReplace>\n
"""
        for (index, message) in self.messages.enumerated() {
            xml += """
  <Message>
    <MessageID>\(index + 1)</MessageID>
    <OperationType>\(message.operationType.rawValue)</OperationType>
    <ProductImage>
      <SKU>\(message.productImage.sku)</SKU><ImageType>\(message.productImage.imageType.rawValue)</ImageType><ImageLocation>\(message.productImage.imageLocation)</ImageLocation>
    </ProductImage>
  </Message>\n
"""
        }
        return xml
*/
    }
}
