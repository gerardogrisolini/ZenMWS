import Foundation

public struct SalePrice : Codable {
    let price : Float
    let currency : Currency
    let startDate: Date
    let endDate: Date
    
    public init(price: Float,  currency: Currency, startDate: Date, endDate: Date) {
        self.price = price
        self.currency = currency
        self.startDate = startDate
        self.endDate = endDate
    }
}
