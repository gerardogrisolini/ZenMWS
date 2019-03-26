import Foundation

public enum Parentage : String, Codable {
    case parent
    case child
}

public enum VariationTheme : String, Codable {
    case sizeColor = "SizeColor"
    case color = "Color"
    case size = "Size"
}

public enum ClothingType : String, Codable, CaseIterable {
    case shirt = "Shirt"
    case sweter = "Sweater"
    case pants = "Pants"
    case shorts = "Shorts"
    case skirt = "Skirt"
    case dress = "Dress"
    case suit = "Suit"
    case blazer = "Blazer"
    case outerwear = "Outerwear"
    case socksHosiery = "SocksHosiery"
    case underwear = "Underwear"
    case bra = "Bra"
    case shoes = "Shoes"
    case hat = "Hat"
    case bag = "Bag"
    case accessory = "Accessory"
    case jewelry = "Jewelry"
    case sleepwear = "Sleepwear"
    case swimwear = "Swimwear"
    case personalBodyCare = "PersonalBodyCare"
    case homeAccessory = "HomeAccessory"
    case nonApparelMisc = "NonApparelMisc"
    case kimono = "Kimono"
    case obi = "Obi"
    case chanchanko = "Chanchanko"
    case jinbei = "Jinbei"
    case yukata = "Yukata"
}

public struct Clothing : Codable {
	let variationData : VariationData
	let classificationData : ClassificationData

    public init(
        variationData: VariationData,
        classificationData: ClassificationData
    ) {
        self.variationData = variationData
        self.classificationData = classificationData
    }
}
