////
////  Miscellaneous.swift
////  mwsWebretail
////
////  Created by Gerardo Grisolini on 06/05/18.
////
//
//import Foundation
//
//public enum MiscType : String, Codable {
//    case shirt = "Shirt"
//    case antiques = "Antiques"
//    case art = "Art"
//    case carPartsAndAccessories = "Car_Parts_and_Accessories"
//    case coins = "Coins"
//    case collectibles = "Collectibles"
//    case crafts = "Crafts"
//    case eventTickets = "Event_Tickets"
//    case flowers = "Flowers"
//    case giftsAndOccasions = "Gifts_and_Occasions"
//    case gourmetFoodAndWine = "Gourmet_Food_and_Wine"
//    case hobbies = "Hobbies"
//    case homeFurnitureAndDecor = "Home_Furniture_and_Decor"
//    case homeLightingAndLamps = "Home_Lighting_and_Lamps"
//    case homeOrganizersAndStorage = "Home_Organizers_and_Storage"
//    case jewelryAndGems = "Jewelry_and_Gems"
//    case luggage = "Luggage"
//    case majorHomeAppliances = "Major_Home_Appliances"
//    case medicalSupplies = "Medical_Supplies"
//    case motorcycles = "Motorcycles"
//    case musicalInstruments = "Musical_Instruments"
//    case petSupplies = "Pet_Supplies"
//    case PotteryAndGlass = "Pottery_and_Glass"
//    case printsAndPosters = "Prints_and_Posters"
//    case scientificSupplies = "Scientific_Supplies"
//    case sportingAndOutdoorGoods = "Sporting_and_Outdoor_Goods"
//    case sportsMemoralibia = "Sports_Memorabilia"
//    case stamps = "Stamps"
//    case teachingAndSchoolSupplies = "Teaching_and_School_Supplies"
//    case watches = "Watches"
//    case wholesaleAndIndustrial = "Wholesale_and_Industrial"
//    case miscOther = "Misc_Other"
//}
//
//public enum MiscSubtype : String, Codable {
//    case decorativeArts = "Decorative_Arts"
//    case forniture = "Furniture"
//    case rugsCarpets = "Rugs_Carpets"
//    case silver = "Silver"
//    case textilesLines = "Textiles_Linens"
//    case drawings = "Drawings"
//    case mixedMedia = "Mixed_Media"
//    case paintings = "Paintings"
//    case sculpturesCarvings = "Sculptures_Carvings"
//    case carAccessories = "Car_Accessories"
//    case carParts = "Car_Parts"
//    case carPerformance = "Car_Performance"
//    case truckAccessories = "Truck_Accessories"
//    case truckParts = "Truck_Parts"
//    case truckPerformannce = "Truck_Performance"
//    case coinsUS = "Coins_US"
//    case coinsWorld = "Coins_World"
//    case paperMoneyUS = "Paper_Money_US"
//    case paperMoneyWorld = "Paper_Money_World"
//    case scripophily = "Scripophily"
//    case autographs = "Autographs"
//    case comics = "Comics"
//    case holidaySeasonal = "Holiday_Seasonal"
//    case militaria = "Militaria"
//    case tradingCards = "Trading_Cards"
//    case corsages = "Corsages"
//    case exotics = "Exotics"
//    case floweringPlants = "Flowering_Plants"
//    case greenPlants = "Green_Plants"
//    case mixedArrangements = "Mixed_Arrangements"
//    case singleFlower = "Single_Flower"
//    case anniversary = "Anniversary"
//    case birthday = "Birthday"
//    case holiday = "Holiday"
//    case wedding = "Wedding"
//    case cheese = "Cheese"
//    case wine = "Wine"
//    case decor = "Decor"
//    case lighting = "Lighting"
//    case lamps = "Lamps"
//    case indoor = "Indoor"
//    case outdoor = "Outdoor"
//    case jewelry = "Jewelry"
//    case gems = "Gems"
//    case garmetBugs = "Garment_Bags"
//    case duffleBrags = "Duffle_Bags"
//    case kitchen = "Kitchen"
//    case laundry = "Laundry"
//    case hospitalSupplies = "Hospital_Supplies"
//    case homeHealth = "Home_Health"
//    case motocycles = "Motorcyles"
//    case motocycleParts = "Motorcycle_Parts"
//    case motocycleProtectiveGear = "Motorcycle_Protective_Gear"
//    case petCare = "Pet_Care"
//    case petFoot = "Pet_Food"
//    case petToys = "Pet_Toys"
//    case glass = "Glass"
//    case pottery = "Pottery"
//    case posters = "Posters"
//    case prints = "Prints"
//    case labSupplies = "Lab_Supplies"
//    case sportingGoods = "Sporting_Goods"
//    case outdoorGear = "Outdoor_Gear"
//    case marine = "Marine"
//    case stampsUS = "Stamps_US"
//    case stampsWorld = "Stamps_World"
//    case preschool = "Preschool"
//    case k12 = "K-12"
//    case specialNeeds = "Special_Needs"
//    case men = "Men"
//    case woman = "Women"
//    case kids = "Kids"
//    case agricolture = "Agriculture"
//    case architecture = "Architecture"
//    case contruction = "Construction"
//    case metalworking = "Metalworking"
//    case other = "Other"
//}
//
//public struct Miscellaneous : Codable {
//    let productType : MiscType
//    let productCategory : MiscType
//    let productSubcategory : MiscSubtype?
//    let color: String?
//    let size: String?
//
//    public init(
//        productType : MiscType,
//        productCategory : MiscType,
//        productSubcategory : MiscSubtype?,
//        color: String?,
//        size: String?
//    ) {
//        self.productType = productType
//        self.productCategory = productCategory
//        self.productSubcategory = productSubcategory
//        self.color = color
//        self.size = size
//    }
//}
