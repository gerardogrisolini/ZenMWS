import Foundation

public struct ClassificationData : Codable {
	let clothingType : ClothingType
	let department : String
	let materialComposition : String
	let outerMaterial : String
    let colorMap : String?
    let sizeMap : String?

    public init(
        clothingType: ClothingType,
        department: String,
        materialComposition: String,
        outerMaterial: String,
        colorMap: String?,
        sizeMap: String?
    ) {
        self.clothingType = clothingType
        self.department = department
        self.materialComposition = materialComposition
        self.outerMaterial = outerMaterial
        self.colorMap = colorMap
        self.sizeMap = sizeMap
    }
}
