import Foundation

public struct ImageMessage : Codable {
	let operationType : OperationType
	let productImage : ProductImage

    public init(
        operationType: OperationType,
        productImage: ProductImage
    ) {
        self.operationType = operationType
        self.productImage = productImage
    }
}
