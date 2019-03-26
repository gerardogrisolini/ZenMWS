import Foundation

public struct Relationship : Codable {
	let parentSKU : String
	let relation : [Relation]

    public init(parentSKU: String,  relation : [Relation]) {
        self.parentSKU = parentSKU
        self.relation = relation
    }
}
