import Foundation

public enum ImageType : String, Codable {
    case main = "Main"      // default image
    case swatch = "Swatch"  // different colour variations (will be rescaled to 30×30 pixels)
    case pt1 = "PT1"        // Secondary photos to be displayed alongside others
    case pt2 = "PT2"
    case pt3 = "PT3"
    case pt4 = "PT4"
    case pt5 = "PT5"
    case pt6 = "PT6"
    case pt7 = "PT7"
    case pt8 = "PT8"
}

public struct ProductImage : Codable {
	let sku : String
	let imageType : ImageType
	let imageLocation : String

    public init(sku: String,  imageType : ImageType, imageLocation: String) {
        self.sku = sku
        self.imageType = imageType
        self.imageLocation = imageLocation
    }
}
