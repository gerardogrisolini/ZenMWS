import Foundation

public struct ProductData : Codable {
//    let miscellaneous : Miscellaneous?
    let clothing : Clothing?

//    public init(miscellaneous: Miscellaneous) {
//        self.miscellaneous = miscellaneous
//        self.clothing = nil
//    }

    public init(clothing: Clothing) {
        self.clothing = clothing
//        self.miscellaneous = nil
    }
}
