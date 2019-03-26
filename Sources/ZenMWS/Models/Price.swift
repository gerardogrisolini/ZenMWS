import Foundation

public typealias MwsPrice = Price

public struct Price : Codable {
	let sku : String
	let standardPrice : StandardPrice
    let salePrice : SalePrice?

    public init(
        sku: String,
        standardPrice: StandardPrice,
        salePrice: SalePrice?
    ) {
        self.sku = sku
        self.standardPrice = standardPrice
        self.salePrice = salePrice
    }
}
