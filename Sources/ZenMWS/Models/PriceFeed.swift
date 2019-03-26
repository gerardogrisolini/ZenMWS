import Foundation

public struct PriceFeed : Feed, Codable {
    
    let purgeAndReplace : Bool
	let messages : [PriceMessage]

    public init(
        purgeAndReplace: Bool,
        messages: [PriceMessage]
    ) {
        self.purgeAndReplace = purgeAndReplace
        self.messages = messages
    }
    
    public func feedType() -> String { return "_POST_PRODUCT_PRICING_DATA_" }

    public func xml(compact: Bool) -> String {

        let doc = ZenMWS.newDocument()
        let envelope = doc.root
        
        envelope.addChild(name: "MessageType", value: "Price")
        envelope.addChild(name: "PurgeAndReplace", value: purgeAndReplace.description)
        
        for (index, message) in self.messages.enumerated() {
            let m = envelope.addChild(name: "Message")
            m.addChild(name: "MessageID", value: "\(index + 1)")
            m.addChild(name: "OperationType", value: message.operationType.rawValue)
            
            let p = m.addChild(name: "Price")
            p.addChild(name: "SKU", value: message.price.sku)
            p.addChild(
                name: "StandardPrice",
                value: message.price.standardPrice.price.description,
                attributes: ["currency" : message.price.standardPrice.currency.rawValue]
            )
            if let sale = message.price.salePrice {
                let s = p.addChild(name: "Sale")
                s.addChild(name: "StartDate", value: sale.startDate.iso8601)
                s.addChild(name: "EndDate", value: sale.endDate.iso8601)
                s.addChild(
                    name: "SalePrice",
                    value: sale.price.description,
                    attributes: ["currency" : sale.currency.rawValue]
                )
            }
        }
        
        return compact ? doc.xmlCompact : doc.xml
/*
        var xml = """
  <MessageType>Price</MessageType>
  <PurgeAndReplace>\(purgeAndReplace)</PurgeAndReplace>\n
"""
        for (index, message) in self.messages.enumerated() {
            xml += """
  <Message>
    <MessageID>\(index + 1)</MessageID>
    <OperationType>\(message.operationType.rawValue)</OperationType>
    <Price>
      <SKU>\(message.price.sku)</SKU>
      <StandardPrice currency="\(message.price.standardPrice.currency.rawValue)">\(message.price.standardPrice.price)</StandardPrice>\n
"""
            if let sale = message.price.salePrice {
                xml += """
      <Sale>
        <StartDate>\(sale.startDate.iso8601)</StartDate>
        <EndDate>\(sale.endDate.iso8601)</EndDate>
        <SalePrice currency="\(sale.currency.rawValue)">\(sale.price)</SalePrice>
      </Sale>\n
"""
            }
            xml += """
    </Price>
  </Message>\n
"""
        }
        return xml
*/
    }
}
