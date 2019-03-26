import Foundation

public struct ProductMessage : Codable {
	let operationType : OperationType
	let product : MwsProduct

    public init(operationType: OperationType,  product : MwsProduct) {
        self.operationType = operationType
        self.product = product
    }
}
