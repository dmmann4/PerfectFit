//
//  EbayNetworking.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/20/25.
//

import Foundation

struct JSONAccessToken: Decodable {
    let accessToken: String
    let expiresIn: Int
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
    }
}

class EbayNetworking {
    
    
    /// search path
    let itemSearchPath =  "/item_summary/search?"
    let ebaySearchUrl = "https://api.sandbox.ebay.com/buy/browse/v1"
    let ebayAuthUrl = "https://api.sandbox.ebay.com/identity/v1/oauth2/token"
    
    func startAuthFlow() {
        let now = Date.now.timeIntervalSince1970
        let expire = UserDefaults.standard.integer(forKey: "expires_in")
        if UserDefaults.standard.string(forKey: "access_token") == nil || expire < Int(now) {
            var request = URLRequest(url: URL(string: ebayAuthUrl)!)
            request.httpMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            let auth = "\(appID):\(certID)".data(using: .utf8)!
            let encoded = auth.base64EncodedString()
            request.setValue("Basic \(encoded)", forHTTPHeaderField: "Authorization")
            let scope = "https://api.ebay.com/oauth/api_scope".addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
            request.httpBody = "grant_type=client_credentials&scope=\(scope)".data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data {
                    do {
                        let accessToken = try JSONDecoder().decode(JSONAccessToken.self, from: data)
                        UserDefaults.standard.set(accessToken.accessToken, forKey: "access_token")
                        let expireDate = Date() + TimeInterval(accessToken.expiresIn)
                        UserDefaults.standard.set(expireDate.timeIntervalSince1970, forKey: "expires_in")
                        
                    } catch {
                        
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    
    func getRelatedItems() {
        var url = URL(string: "\(ebaySearchUrl)\(itemSearchPath)")!
        url.append(queryItems: [URLQueryItem(name: "q", value: "golf")])
        var request = URLRequest(url: url)
        guard let accessToken = UserDefaults.standard.string(forKey: "access_token") else { return }
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data {
                print(String(data: data, encoding: .utf8)?.replacingOccurrences(of: "'\'", with: ""))
                do {
                    let ebayResponse = try JSONDecoder().decode(EbayResponse.self, from: data)
                    print("HEY I FOUND SOMETHING!!!!")
                    ebayResponse.itemSummaries?.forEach { item in
                        print(item.title)
                    }
                } catch (let error) {
                    print("ERROR HERE --- \(error)")
                }
                
            }
        }
        task.resume()
    }
}

import Foundation

// MARK: - EbayResponse
struct EbayResponse: Codable {
    let autoCorrections: AutoCorrections?
    let href: String?
    let itemSummaries: [ItemSummary]?
    let limit, next, offset, prev: String?
    let refinement: Refinement?
    let total: String?
    let warnings: [Warning]?
}

// MARK: - AutoCorrections
struct AutoCorrections: Codable {
    let q: String?
}

// MARK: - ItemSummary
struct ItemSummary: Codable {
    let additionalImages: [Image]?
    let adultOnly, availableCoupons, bidCount: String?
    let buyingOptions: [String]?
    let categories: [Category]?
    let compatibilityMatch: String?
    let compatibilityProperties: [CompatibilityProperty]?
    let condition, conditionID: String?
    let currentBidPrice: CurrentBidPrice?
    let distanceFromPickupLocation: DistanceFromPickupLocation?
    let energyEfficiencyClass, epid: String?
    let image: Image?
    let itemAffiliateWebURL, itemCreationDate, itemEndDate, itemGroupHref: String?
    let itemGroupType, itemHref, itemID: String?
    let itemLocation: ItemLocation?
    let itemWebURL: String?
    let leafCategoryIDS: [String]?
    let legacyItemID, listingMarketplaceID: String?
    let marketingPrice: MarketingPrice?
    let pickupOptions: [PickupOption]?
    let price: CurrentBidPrice?
    let priceDisplayCondition, priorityListing: String?
    let qualifiedPrograms: [String]?
    let seller: Seller?
    let shippingOptions: [ShippingOption]?
    let shortDescription: String?
    let thumbnailImages: [Image]?
    let title, topRatedBuyingExperience, tyreLabelImageURL: String?
    let unitPrice: CurrentBidPrice?
    let unitPricingMeasure, watchCount: String?

    enum CodingKeys: String, CodingKey {
        case additionalImages, adultOnly, availableCoupons, bidCount, buyingOptions, categories, compatibilityMatch, compatibilityProperties, condition
        case conditionID = "conditionId"
        case currentBidPrice, distanceFromPickupLocation, energyEfficiencyClass, epid, image
        case itemAffiliateWebURL = "itemAffiliateWebUrl"
        case itemCreationDate, itemEndDate, itemGroupHref, itemGroupType, itemHref
        case itemID = "itemId"
        case itemLocation
        case itemWebURL = "itemWebUrl"
        case leafCategoryIDS = "leafCategoryIds"
        case legacyItemID = "legacyItemId"
        case listingMarketplaceID = "listingMarketplaceId"
        case marketingPrice, pickupOptions, price, priceDisplayCondition, priorityListing, qualifiedPrograms, seller, shippingOptions, shortDescription, thumbnailImages, title, topRatedBuyingExperience
        case tyreLabelImageURL = "tyreLabelImageUrl"
        case unitPrice, unitPricingMeasure, watchCount
    }
}

// MARK: - Image
struct Image: Codable {
    let height, imageURL, width: String?

    enum CodingKeys: String, CodingKey {
        case height
        case imageURL = "imageUrl"
        case width
    }
}

// MARK: - Category
struct Category: Codable {
    let categoryID, categoryName: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName
    }
}

// MARK: - CompatibilityProperty
struct CompatibilityProperty: Codable {
    let localizedName, name, value: String?
}

// MARK: - CurrentBidPrice
struct CurrentBidPrice: Codable {
    let convertedFromCurrency, convertedFromValue, currency, value: String?
}

// MARK: - DistanceFromPickupLocation
struct DistanceFromPickupLocation: Codable {
    let unitOfMeasure, value: String?
}

// MARK: - ItemLocation
struct ItemLocation: Codable {
    let addressLine1, addressLine2, city, country: String?
    let county, postalCode, stateOrProvince: String?
}

// MARK: - MarketingPrice
struct MarketingPrice: Codable {
    let discountAmount: CurrentBidPrice?
    let discountPercentage: String?
    let originalPrice: CurrentBidPrice?
    let priceTreatment: String?
}

// MARK: - PickupOption
struct PickupOption: Codable {
    let pickupLocationType: String?
}

// MARK: - Seller
struct Seller: Codable {
    let feedbackPercentage, feedbackScore, sellerAccountType, username: String?
}

// MARK: - ShippingOption
struct ShippingOption: Codable {
    let guaranteedDelivery, maxEstimatedDeliveryDate, minEstimatedDeliveryDate: String?
    let shippingCost: CurrentBidPrice?
    let shippingCostType: String?
}

// MARK: - Refinement
struct Refinement: Codable {
    let aspectDistributions: [AspectDistribution]?
    let buyingOptionDistributions: [BuyingOptionDistribution]?
    let categoryDistributions: [CategoryDistribution]?
    let conditionDistributions: [ConditionDistribution]?
    let dominantCategoryID: String?

    enum CodingKeys: String, CodingKey {
        case aspectDistributions, buyingOptionDistributions, categoryDistributions, conditionDistributions
        case dominantCategoryID = "dominantCategoryId"
    }
}

// MARK: - AspectDistribution
struct AspectDistribution: Codable {
    let aspectValueDistributions: [AspectValueDistribution]?
    let localizedAspectName: String?
}

// MARK: - AspectValueDistribution
struct AspectValueDistribution: Codable {
    let localizedAspectValue, matchCount, refinementHref: String?
}

// MARK: - BuyingOptionDistribution
struct BuyingOptionDistribution: Codable {
    let buyingOption, matchCount, refinementHref: String?
}

// MARK: - CategoryDistribution
struct CategoryDistribution: Codable {
    let categoryID, categoryName, matchCount, refinementHref: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName, matchCount, refinementHref
    }
}

// MARK: - ConditionDistribution
struct ConditionDistribution: Codable {
    let condition, conditionID, matchCount, refinementHref: String?

    enum CodingKeys: String, CodingKey {
        case condition
        case conditionID = "conditionId"
        case matchCount, refinementHref
    }
}

// MARK: - Warning
struct Warning: Codable {
    let category, domain, errorID: String?
    let inputRefIDS: [String]?
    let longMessage, message: String?
    let outputRefIDS: [String]?
    let parameters: [Parameter]?
    let subdomain: String?

    enum CodingKeys: String, CodingKey {
        case category, domain
        case errorID = "errorId"
        case inputRefIDS = "inputRefIds"
        case longMessage, message
        case outputRefIDS = "outputRefIds"
        case parameters, subdomain
    }
}

// MARK: - Parameter
struct Parameter: Codable {
    let name, value: String?
}
