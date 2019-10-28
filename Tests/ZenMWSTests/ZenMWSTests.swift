import XCTest
@testable import ZenMWS

final class ZenMWSTests: XCTestCase {
    
    static var config = Config(
        endpoint: "mws-eu.amazonservices.com",
        marketplaceId: "APJ6JRA9NG5V4",
        sellerId: "A13I2O1RE4ALEL",
        accessKey: "AKIAJMIJZF676VEJT4JA",
        secretKey: "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",
        authToken: "amzn.mws.56b161b3-fd76-94f8-86ce-4d9224a42d58",
        userAgent: "Webretail/1.0 (Language=Swift/4.1)"
    )
    
    let mws = ZenMWS(config: config, notify: printLog)
    
    func getProductFeed() -> ProductFeed {
        let messages = [
            ProductMessage(
                operationType: .update,
                product: Product(
                    sku: "GAIA12321-47",
                    standardProductID: StandardProductID(type: .EAN, value: "6889865440084"),
                    condition: Condition(conditionType: .new),
                    itemPackageQuantity: 1,
                    numberOfItems: 1,
                    descriptionData: DescriptionData(
                        title: "Gaia (Unique, Neutral)",
                        brand: "Tessilnova",
                        description: "Single article no variants for test."),
                    productData: ProductData(
                        clothing: Clothing(
                            variationData: VariationData(
                                parentage: .parent,
                                size: "Unique",
                                color: "Neutral",
                                variationTheme: .sizeColor
                            ),
                            classificationData: ClassificationData(
                                clothingType: .outerwear,
                                department: "Women",
                                materialComposition: "Wool",
                                outerMaterial: "Wool",
                                colorMap: nil,
                                sizeMap: nil
                            )
                        )
                    )
                )
            )
        ]
        
        return ProductFeed(
            purgeAndReplace: true,
            messages: messages
        )
    }
    
    func testProduct() {
        let productFeed = getProductFeed()
        postMessage(feedType: productFeed.feedType(), xml: productFeed.xml(compact: true))
    }
    
    func getProductsFeed() -> ProductFeed {
        let messages = [
            ProductMessage(
                operationType: .update,
                product: Product(
                    sku: "WEB1002244",
                    standardProductID: nil,
                    condition: nil,
                    itemPackageQuantity: nil,
                    numberOfItems: nil,
                    descriptionData: DescriptionData(
                        title: "Gerardo",
                        brand: "Tessilnova",
                        description: "Model velor wool and cashmere lined in non-repeatable template satin while stocks last."),
                    productData: ProductData(
                        clothing: Clothing(
                            variationData: VariationData(
                                parentage: .parent,
                                size: nil,
                                color: nil,
                                variationTheme: .sizeColor
                            ),
                            classificationData: ClassificationData(
                                clothingType: .outerwear,
                                department: "Man",
                                materialComposition: "Wool",
                                outerMaterial: "Wool",
                                colorMap: nil,
                                sizeMap: nil
                            )
                        )
                    )
                )
            ),
            ProductMessage(
                operationType: .update,
                product: Product(
                    sku: "WEB1002244-0",
                    standardProductID: StandardProductID(type: .EAN, value: "6877302372005"),
                    condition: Condition(conditionType: .new),
                    itemPackageQuantity: 1,
                    numberOfItems: 1,
                    descriptionData: DescriptionData(
                        title: "Gerardo (40, Bianco)",
                        brand: "Tessilnova",
                        description: "Model velor wool and cashmere lined in non-repeatable template satin while stocks last."),
                    productData: ProductData(
                        clothing: Clothing(
                            variationData: VariationData(
                                parentage: .parent,
                                size: "40",
                                color: "Bianco",
                                variationTheme: .sizeColor
                            ),
                            classificationData: ClassificationData(
                                clothingType: .outerwear,
                                department: "Man",
                                materialComposition: "Wool",
                                outerMaterial: "Wool",
                                colorMap: "Bianco",
                                sizeMap: "40"
                            )
                        )
                    )
                )
            ),
            ProductMessage(
                operationType: .update,
                product: Product(
                    sku: "WEB1002244-1",
                    standardProductID: StandardProductID(type: .EAN, value: "6860473735861"),
                    condition: Condition(conditionType: .new),
                    itemPackageQuantity: 1,
                    numberOfItems: 1,
                    descriptionData: DescriptionData(
                        title: "Gerardo (42, Bianco)",
                        brand: "Tessilnova",
                        description: "Model velor wool and cashmere lined in non-repeatable template satin while stocks last."),
                    productData: ProductData(
                        clothing: Clothing(
                            variationData: VariationData(
                                parentage: .parent,
                                size: "42",
                                color: "Bianco",
                                variationTheme: .sizeColor
                            ),
                            classificationData: ClassificationData(
                                clothingType: .outerwear,
                                department: "Man",
                                materialComposition: "Wool",
                                outerMaterial: "Wool",
                                colorMap: "Bianco",
                                sizeMap: "42"
                            )
                        )
                    )
                )
            ),
            ProductMessage(
                operationType: .update,
                product: Product(
                    sku: "WEB1002244-2",
                    standardProductID: StandardProductID(type: .EAN, value: "6868317360521"),
                    condition: Condition(conditionType: .new),
                    itemPackageQuantity: 1,
                    numberOfItems: 1,
                    descriptionData: DescriptionData(
                        title: "Gerardo (44, Bianco)",
                        brand: "Tessilnova",
                        description: "Model velor wool and cashmere lined in non-repeatable template satin while stocks last."),
                    productData: ProductData(
                        clothing: Clothing(
                            variationData: VariationData(
                                parentage: .parent,
                                size: "44",
                                color: "Bianco",
                                variationTheme: .sizeColor
                            ),
                            classificationData: ClassificationData(
                                clothingType: .outerwear,
                                department: "Man",
                                materialComposition: "Wool",
                                outerMaterial: "Wool",
                                colorMap: "Bianco",
                                sizeMap: "44"
                            )
                        )
                    )
                )
            )
        ]
        
        return ProductFeed(
            purgeAndReplace: true,
            messages: messages
        )
    }
    
    func testProducts() {
        let productFeed = getProductsFeed()
        postMessage(feedType: productFeed.feedType(), xml: productFeed.xml(compact: false))
    }
    
    func getRelationshipFeed() -> RelationshipFeed {
        let messages = [
            RelationshipMessage(
                operationType: .update,
                relationship: Relationship(
                    parentSKU: "WEB1002244",
                    relation: [
                        Relation(
                            sku: "WEB1002244-0",
                            type: .variation
                        ),
                        Relation(
                            sku: "WEB1002244-1",
                            type: .variation
                        ),
                        Relation(
                            sku: "WEB1002244-2",
                            type: .variation
                        )
                    ]
                )
            )
        ]
        
        return RelationshipFeed(
            purgeAndReplace: true,
            messages: messages
        )
    }
    
    func testRelatiships() {
        let relationshipFeed = getRelationshipFeed()
        postMessage(feedType: relationshipFeed.feedType(), xml: relationshipFeed.xml(compact: false))
    }
    
    
    func getImageFeed() -> ImageFeed {
        let messages = [
            ImageMessage(
                operationType: .update,
                productImage: ProductImage(
                    sku: "GAIA12321-47",
                    imageType: .main,
                    imageLocation: "http://www.webretail.cloud/media/hwe9-8bZyaEga54mxDXnMg.jpg"
                )
            ),
            ImageMessage(
                operationType: .update,
                productImage: ProductImage(
                    sku: "GAIA12321-47",
                    imageType: .pt1,
                    imageLocation: "http://www.webretail.cloud/media/2gITOx2cNUxYfFdMua1bfw.jpg"
                )
            )
        ]
        
        return ImageFeed(
            purgeAndReplace: true,
            messages: messages
        )
    }
    
    func testImage() {
        let imageFeed = getImageFeed()
        postMessage(feedType: imageFeed.feedType(), xml: imageFeed.xml(compact: true))
    }
    
    func getPriceFeed() -> PriceFeed {
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        let messages = [
            PriceMessage(
                operationType: .update,
                price: Price(
                    sku: "WEB1002244-0",
                    standardPrice: StandardPrice(price: 320, currency: .eur),
                    salePrice: nil
                )
            ),
            PriceMessage(
                operationType: .update,
                price: Price(
                    sku: "WEB1002244-1",
                    standardPrice: StandardPrice(price: 320, currency: .eur),
                    salePrice: nil
                )
            ),
            PriceMessage(
                operationType: .update,
                price: Price(
                    sku: "WEB1002244-2",
                    standardPrice: StandardPrice(price: 320, currency: .eur),
                    salePrice: SalePrice(
                        price: 200,
                        currency: .eur,
                        startDate: format.date(from: "2018/05/01")!,
                        endDate: format.date(from: "2018/12/31")!
                    )
                )
            )
        ]
        
        return PriceFeed(
            purgeAndReplace: true,
            messages: messages
        )
    }
    
    func testPrices() {
        let priceFeed = getPriceFeed()
        postMessage(feedType: priceFeed.feedType(), xml: priceFeed.xml(compact: false))
    }
    
    func getInventoryFeed() -> InventoryFeed {
        let messages = [
            InventoryMessage(
                operationType: .update,
                inventory: Inventory(
                    sku: "WEB1002244-0",
                    quantity: 5
                )
            ),
            InventoryMessage(
                operationType: .update,
                inventory: Inventory(
                    sku: "WEB1002244-1",
                    quantity: 5
                )
            ),
            InventoryMessage(
                operationType: .update,
                inventory: Inventory(
                    sku: "WEB1002244-2",
                    quantity: 5
                )
            )
        ]
        
        return InventoryFeed(
            purgeAndReplace: true,
            messages: messages
        )
    }
    
    func testQuantities() {
        let inventoryFeed = getInventoryFeed()
        postMessage(feedType: inventoryFeed.feedType(), xml: inventoryFeed.xml(compact: false))
    }
    
    func testResult() {
        let expectation = XCTestExpectation(description: "Amazon MWS")
        
        mws.result(feedSubmissionId: "50060017648") { (result) -> (Void) in
            expectation.fulfill()
            print(result.errorDescription)
            XCTAssertEqual(result.messagesWithError, 0)
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    fileprivate func postMessage(feedType: String, xml: String) {
        let expectation = XCTestExpectation(description: "Amazon MWS")
        
        mws.post(feedType: feedType, xml: xml) { (result) -> (Void) in
            expectation.fulfill()
            print(result.errorDescription)
            XCTAssertEqual(result.feedProcessingStatus, "_SUBMITTED_")
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    static var requestCount = 0
    static func printLog(request: RequestFeed) {
        requestCount += 1
        print("\(request.requestId): \(request.requestCreatedAt.formatDate()) -> \(request.requestSubmittedAt.formatDate()) -> \(request.requestCompletedAt.formatDate()) \(request.errorDescription)")
    }
    
    func testThread() {
        let requests : [RequestFeed] = [
            RequestFeed(sku: "WEB1002288", feed: getProductFeed(), id: 1),
            RequestFeed(sku: "WEB1002288", feed: getRelationshipFeed(), id: 2, parentId: 1),
            RequestFeed(sku: "WEB1002288", feed: getImageFeed(), id: 3, parentId: 2),
            RequestFeed(sku: "WEB1002288", feed: getPriceFeed(), id: 4, parentId: 3),
            RequestFeed(sku: "WEB1002288", feed: getInventoryFeed(), id: 5, parentId: 4),
        ]
        mws.start(requests: requests)
        
        sleep(20)
        //mws.stop()
        
        XCTAssertTrue(requests.count > 0)
    }
    
    static var allTests = [
        ("testProduct", testProduct),
        ("testProducts", testProducts),
        ("testRelatiships", testRelatiships),
        ("testImage", testImage),
        ("testPrices", testPrices),
        ("testQuantities", testQuantities),
        ("testResult", testResult),
        ("testThread", testThread)
    ]
}
