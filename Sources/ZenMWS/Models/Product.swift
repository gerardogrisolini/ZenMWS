import Foundation

public enum OperationType : String, Codable {
    case update = "Update"
    case delete = "Delete"
}

public typealias MwsProduct = Product

public struct Product : Codable {
	let sku : String
    let standardProductID : StandardProductID?
    let condition : Condition?
    let itemPackageQuantity : Int?
    let numberOfItems : Int?
	let descriptionData : DescriptionData
	let productData : ProductData

    public init(
        sku: String,
        standardProductID: StandardProductID?,
        condition: Condition?,
        itemPackageQuantity: Int?,
        numberOfItems: Int?,
        descriptionData: DescriptionData,
        productData: ProductData
    ) {
        self.sku = sku
        self.standardProductID = standardProductID
        self.condition = condition
        self.itemPackageQuantity = itemPackageQuantity
        self.numberOfItems = numberOfItems
        self.descriptionData = descriptionData
        self.productData = productData
    }
}
