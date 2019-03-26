import Foundation

public struct VariationData : Codable {
	let parentage : Parentage
    let size : String?
    let color : String?
	let variationTheme : VariationTheme

    public init(
        parentage: Parentage,
        size: String?,
        color: String?,
        variationTheme: VariationTheme
    ) {
        self.parentage = parentage
        self.size = size
        self.color = color
        self.variationTheme = variationTheme
    }
}
