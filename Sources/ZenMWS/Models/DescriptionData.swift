import Foundation

public struct DescriptionData : Codable {
	let title : String
	let brand : String
	let description : String

    public init(
        title: String,
        brand: String,
        description: String
    ) {
        self.title = title
        self.brand = brand
        self.description = description
    }
}
