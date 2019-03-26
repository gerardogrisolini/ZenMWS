import Foundation

public struct PriceMessage : Codable {
	let operationType : OperationType
	let price : MwsPrice

    public init(
        operationType: OperationType,
        price: MwsPrice
    ) {
        self.operationType = operationType
        self.price = price
    }
}
