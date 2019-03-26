import Foundation

public enum Currency : String, Codable {
    case eur = "EUR"
    case usd = "USD"
}

public struct StandardPrice : Codable {
	let price : Float
	let currency : Currency

    public init(price: Float,  currency: Currency) {
        self.price = price
        self.currency = currency
    }
}
