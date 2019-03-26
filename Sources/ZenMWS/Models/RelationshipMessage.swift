import Foundation

public struct RelationshipMessage : Codable {
	let operationType : OperationType
	let relationship : Relationship

    public init(operationType: OperationType,  relationship : Relationship) {
        self.operationType = operationType
        self.relationship = relationship
    }
}
