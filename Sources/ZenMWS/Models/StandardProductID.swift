import Foundation

public enum StandardProductIDType : String, Codable {
    case EAN = "EAN"
    case ASIN = "ASIN"
}

public struct StandardProductID : Codable {
	let type : StandardProductIDType
	let value : String
    
    public init(type: StandardProductIDType, value: String) {
        self.type = type
        self.value = value
    }
}
