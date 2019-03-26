import Foundation

public struct Inventory : Codable {
	let sku : String
	let quantity : Int

    public init(
        sku: String,
        quantity: Int
    ) {
        self.sku = sku
        self.quantity = quantity
    }
}
