import Foundation

public enum RelationType : String, Codable {
    case variation = "Variation"
    case displaySet = "DisplaySet"
    case collection = "Collection"
    case accessory = "Accessory"
    case customized = "Customized"
    case part = "Part"
    case complements = "Complements"
    case piece = "Piece"
    case necessary = "Necessary"
    case replacementPart = "ReplacementPart"
    case similar = "Similar"
    case episode = "Episode"
    case season = "Season"
    case merchantTitleAuthority = "MerchantTitleAuthority"
    case component = "Component"
}

public struct Relation : Codable {
    let sku : String
    let type : RelationType

    public init(sku: String,  type : RelationType) {
        self.sku = sku
        self.type = type
    }
}
