import Foundation

public enum ConditionType : String, Codable {
    case new = "New"
    case usedLikeNew = "UsedLikeNew"
    case usedVeryGood = "UsedVeryGood"
    case refurbished = "Refurbished"
}

public struct Condition : Codable {
	let conditionType : ConditionType

    public init(
        conditionType: ConditionType
    ) {
        self.conditionType = conditionType
    }
}
