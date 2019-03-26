import Foundation

public struct InventoryMessage : Codable {
	let operationType : OperationType
	let inventory : Inventory

    public init(
        operationType: OperationType,
        inventory: Inventory
    ) {
        self.operationType = operationType
        self.inventory = inventory
    }
}
