import Foundation
import AEXML

public struct ProductFeed : Feed, Codable {
    
    let purgeAndReplace : Bool
	let messages : [ProductMessage]

    public init(purgeAndReplace: Bool,  messages : [ProductMessage]) {
        self.purgeAndReplace = purgeAndReplace
        self.messages = messages
    }

    public func feedType() -> String { return "_POST_PRODUCT_DATA_" }

    public func xml(compact: Bool) -> String {
        
        let doc = ZenMWS.newDocument()
        let envelope = doc.root
        
        envelope.addChild(name: "MessageType", value: "Product")
        envelope.addChild(name: "PurgeAndReplace", value: purgeAndReplace.description)

        for (index, message) in self.messages.enumerated() {
            let m = envelope.addChild(name: "Message")
            m.addChild(name: "MessageID", value: "\(index + 1)")
            m.addChild(name: "OperationType", value: message.operationType.rawValue)

            let p = m.addChild(name: "Product")
            p.addChild(name: "SKU", value: message.product.sku)
            
            if let standardProductID = message.product.standardProductID {
                let s = p.addChild(name: "StandardProductID")
                s.addChild(name: "Type", value: standardProductID.type.rawValue)
                s.addChild(name: "Value", value: standardProductID.value)
            }
            
            if let condition = message.product.condition {
                let c = p.addChild(name: "Condition")
                c.addChild(name: "ConditionType", value: condition.conditionType.rawValue)
            }
            
            if let itemPackageQuantity = message.product.itemPackageQuantity {
                p.addChild(name: "ItemPackageQuantity", value: itemPackageQuantity.description)
            }
            
            if let numberOfItems = message.product.numberOfItems {
                p.addChild(name: "NumberOfItems", value: numberOfItems.description)
            }
            
            let d = p.addChild(name: "DescriptionData")
            d.addChild(name: "Title", value: message.product.descriptionData.title)
            d.addChild(name: "Brand", value: message.product.descriptionData.brand)
            d.addChild(name: "Description", value: message.product.descriptionData.description)

            
            let pd = p.addChild(name: "ProductData")

//            if let miscellaneous = message.product.productData.miscellaneous {
//                let d = pd.addChild(name: "Miscellaneous")
//                d.addChild(name: "ProductType", value: miscellaneous.productType.rawValue)
//                d.addChild(name: "ProductCategory", value: miscellaneous.productCategory.rawValue)
//                if let subcategory = miscellaneous.productSubcategory {
//                    d.addChild(name: "ProductSubcategory", value: subcategory.rawValue)
//                }
//                if let color = miscellaneous.color {
//                    d.addChild(name: "Color", value: color)
//                }
//                if let size = miscellaneous.size {
//                    d.addChild(name: "Size", value: size)
//                }
//            }
            
            if let clothing = message.product.productData.clothing {
            
                let c = pd.addChild(name: "Clothing")
                
                let vd = c.addChild(name: "VariationData")
                vd.addChild(name: "Parentage", value: clothing.variationData.parentage.rawValue)
                if let size = clothing.variationData.size {
                    vd.addChild(name: "Size", value: size)
                }
                if let color = clothing.variationData.color {
                    vd.addChild(name: "Color", value: color)
                }
                vd.addChild(name: "VariationTheme", value: clothing.variationData.variationTheme.rawValue)

                let cd = c.addChild(name: "ClassificationData")
                cd.addChild(name: "ClothingType", value: clothing.classificationData.clothingType.rawValue)
                cd.addChild(name: "Department", value: clothing.classificationData.department)
                if let colorMap = clothing.classificationData.colorMap {
                    cd.addChild(name: "ColorMap", value: colorMap)
                }
                cd.addChild(name: "MaterialComposition", value: clothing.classificationData.materialComposition)
                cd.addChild(name: "OuterMaterial", value: clothing.classificationData.outerMaterial)
                if let sizeMap = clothing.classificationData.sizeMap {
                    cd.addChild(name: "SizeMap", value: sizeMap)
                }
            }
        }
        
        return compact ? doc.xmlCompact : doc.xml

/*
        var xml = """
  <MessageType>Product</MessageType>
  <PurgeAndReplace>\(purgeAndReplace)</PurgeAndReplace>\n
"""
        for (index, message) in self.messages.enumerated() {
            xml += """
  <Message>
    <MessageID>\(index + 1)</MessageID>
    <OperationType>\(message.operationType.rawValue)</OperationType>
    <Product>
      <SKU>\(message.product.sku)</SKU>\n
"""
            if let standardProductID = message.product.standardProductID {
                xml += """
      <StandardProductID>
        <Type>\(standardProductID.type)</Type>
        <Value>\(standardProductID.value)</Value>
      </StandardProductID>\n
"""
            }
            if let condition = message.product.condition {
                xml += """
      <Condition>
        <ConditionType>\(condition.conditionType.rawValue)</ConditionType>
      </Condition>\n
"""
            }
            if let itemPackageQuantity = message.product.itemPackageQuantity {
                xml += """
      <ItemPackageQuantity>\(itemPackageQuantity)</ItemPackageQuantity>\n
"""
            }
            if let numberOfItems = message.product.numberOfItems {
                xml += """
      <NumberOfItems>\(numberOfItems)</NumberOfItems>\n
"""
            }
            xml += """
      <DescriptionData>
        <Title>\(message.product.descriptionData.title)</Title>
        <Brand>\(message.product.descriptionData.brand)</Brand>
        <Description>\(message.product.descriptionData.description)</Description>
      </DescriptionData>
      <ProductData>\n
"""
            // Miscellaneous
            if let miscellaneous = message.product.productData.miscellaneous {
                xml += """
        <Miscellaneous>
          <ProductType>\(miscellaneous.productType.rawValue)</ProductType>
          <ProductCategory>\(miscellaneous.productCategory.rawValue)</ProductCategory>\n
"""
                if let subcategory = miscellaneous.productSubcategory {
                    xml += """
          <ProductSubcategory>\(subcategory.rawValue)</ProductSubcategory>\n
"""
                }
                if let color = miscellaneous.color {
                    xml += """
          <Color>\(color)</Color>\n
"""
                }
                if let size = miscellaneous.size {
                    xml += """
          <Size>\(size)</Size>\n
"""
                }
                xml += """
        </Miscellaneous>\n
"""
            }
            // Clothing
            if let clothing = message.product.productData.clothing {
                xml += """
        <Clothing>
          <VariationData>
            <Parentage>\(clothing.variationData.parentage)</Parentage>\n
"""
                if let size = clothing.variationData.size {
                    xml += """
            <Size>\(size)</Size>\n
"""
                }
                if let color = clothing.variationData.color {
                    xml += """
            <Color>\(color)</Color>\n
"""
                }
                xml += """
            <VariationTheme>\(clothing.variationData.variationTheme.rawValue)</VariationTheme>
          </VariationData>
          <ClassificationData>
            <ClothingType>\(clothing.classificationData.clothingType.rawValue)</ClothingType>
            <Department>\(clothing.classificationData.department)</Department>\n
"""
                if let colorMap = clothing.classificationData.colorMap {
                    xml += """
            <ColorMap>\(colorMap)</ColorMap>\n
"""
                }
                xml += """
            <MaterialComposition>\(clothing.classificationData.materialComposition)</MaterialComposition>
            <OuterMaterial>\(clothing.classificationData.outerMaterial)</OuterMaterial>\n
"""
                if let sizeMap = clothing.classificationData.sizeMap {
                    xml += """
            <SizeMap>\(sizeMap)</SizeMap>\n
"""
                }
                xml += """
          </ClassificationData>
        </Clothing>\n
"""
            }
            xml += """
      </ProductData>
    </Product>
  </Message>\n
"""
        }

        return xml
*/
    }
}
