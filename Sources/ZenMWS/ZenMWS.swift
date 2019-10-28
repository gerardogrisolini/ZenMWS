//
//  mwsWebretail.swift
//  mwsWebretail
//
//  Created by Gerardo Grisolini on 13/01/18.
//

import Foundation
#if os(Linux)
import FoundationXML
import FoundationNetworking
#endif
import CryptoSwift
import AEXML

public class ZenMWS: NSObject, XMLParserDelegate {
    
    private let cfg: Config
    private var currentElementName: String = ""
    private var feedSubmissionInfo: FeedSubmissionInfo!
    
    public static var sellerId : String = ""

    public init(config: Config, notify: ((_ feed: RequestFeed) -> Void)?) {
        self.cfg = config
        self.notify = notify
        super.init()
        ZenMWS.sellerId = config.sellerId
    }
    
    public static func newDocument() -> AEXMLDocument {
        let soapRequest = AEXMLDocument(root: nil, options: AEXMLOptions())
        let attributes = ["xmlns:xsi" : "http://www.w3.org/2001/XMLSchema-instance", "xsi:noNamespaceSchemaLocation" : "amzn-envelope.xsd"]
        let envelope = soapRequest.addChild(name: "AmazonEnvelope", attributes: attributes)
        let header = envelope.addChild(name: "Header")
        header.addChild(name: "DocumentVersion", value: "1.01")
        header.addChild(name: "MerchantIdentifier", value: ZenMWS.sellerId)
        return soapRequest
    }

    public func post(feed: Feed, completionHandler: @escaping ((FeedSubmissionInfo) -> (Void))) {
        self.post(feedType: feed.feedType(), xml: feed.xml(compact: true), completionHandler: completionHandler)
    }
    
    public func post(feedType: String, xml: String, completionHandler: @escaping ((FeedSubmissionInfo) -> (Void))) {
//        let signed = xml.digest(.md5)!.encode(.base64)!
//        let contentMD5Value = String(validatingUTF8: signed)!
        let contentMD5Value = Digest.md5(xml.bytes).toBase64()!
        
        var parameters = [String]()
        parameters.append("AWSAccessKeyId=" + cfg.accessKey)
        parameters.append("Action=SubmitFeed")
        parameters.append("ContentMD5Value=" + contentMD5Value.encodeURIComponent()!)
        parameters.append("FeedType=" + feedType)
        parameters.append("MWSAuthToken=" + cfg.authToken)
        parameters.append("MarketplaceIdList.Id.1=" + cfg.marketplaceId)
        parameters.append("Merchant=" + cfg.sellerId)
        parameters.append("SignatureMethod=HmacSHA256")
        parameters.append("SignatureVersion=2")
        parameters.append("Timestamp=" + Date().iso8601.encodeURIComponent()!)
        parameters.append("Version=" + cfg.version)
        let paramString = parameters.joined(separator: "&")
        
        self.process(paramString: paramString, xml: xml, completionHandler: completionHandler)
    }
    
    private func process(paramString: String, xml: String?, completionHandler: @escaping ((FeedSubmissionInfo) -> (Void))){

        let signingKey = "POST\n\(cfg.endpoint)\n/\n\(paramString)"

//        let base64 = signingKey.sign(.sha256, key: HMACKey(cfg.secretKey))!.encode(.base64)!
//        let signature = String(validatingUTF8: base64)!
        let signature = try! HMAC(key: cfg.secretKey, variant: .sha256).authenticate(signingKey.bytes).toBase64()!
        //let signature = Digest.sha256(signingKey.bytes).toBase64()!
        
        let amazonUrl =  "https://\(cfg.endpoint)/?\(paramString)&Signature=\(signature.encodeURIComponent()!)"
        var request = URLRequest(url: URL(string: amazonUrl)!)
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Host"] = cfg.endpoint
        headers["User-Agent"] = cfg.userAgent
        headers["Content-Type"] = "text/xml; charset=UTF-8"
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        if let xml = xml {
            request.httpBody = xml.data(using: .utf8, allowLossyConversion: false)!
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.feedSubmissionInfo = FeedSubmissionInfo()
            
            guard error == nil, let data = data else {
                self.feedSubmissionInfo.error(text: error!.localizedDescription)
                completionHandler(self.feedSubmissionInfo)
                return
            }
            
            let xmlParser = XMLParser(data: data)
            xmlParser.delegate = self
            //xmlParser.shouldResolveExternalEntities = true
            
            if !xmlParser.parse() {
                self.feedSubmissionInfo.error(text: "error parsing soap response")
            }
            
            completionHandler(self.feedSubmissionInfo)
        }
        task.resume()
    }
    
    public func result(feedSubmissionId: String, completionHandler: @escaping ((FeedSubmissionInfo) -> (Void))) {
        var parameters = [String]();
        parameters.append("AWSAccessKeyId=" + cfg.accessKey)
        parameters.append("Action=GetFeedSubmissionResult")
        parameters.append("FeedSubmissionId=" + feedSubmissionId)
        parameters.append("MWSAuthToken=" + cfg.authToken)
        parameters.append("MarketplaceIdList.Id.1=" + cfg.marketplaceId)
        parameters.append("Merchant=" + cfg.sellerId)
        parameters.append("SignatureMethod=HmacSHA256")
        parameters.append("SignatureVersion=2")
        parameters.append("Timestamp=" + Date().iso8601.encodeURIComponent()!)
        parameters.append("Version=" + cfg.version)
        let paramString = parameters.joined(separator: "&")
        
        self.process(paramString: paramString, xml: nil, completionHandler: completionHandler)
    }
    
    
    // XMLParserDelegate
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElementName = elementName
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        
        switch currentElementName {
        case "FeedSubmissionId":
            self.feedSubmissionInfo.feedSubmissionId = string
            break
        case "FeedProcessingStatus":
            self.feedSubmissionInfo.feedProcessingStatus = string
            break
        case "Code":
            self.feedSubmissionInfo.statusCode = string
            self.feedSubmissionInfo.messagesWithError = 1
            break
        case "StatusCode":
            self.feedSubmissionInfo.statusCode = string
            break
        case "ResultDescription", "Message":
            self.feedSubmissionInfo.errorDescription += "\(string) "
            break
        case "MessagesProcessed":
            self.feedSubmissionInfo.messagesProcessed = Int(string)!
            break
        case "MessagesSuccessful":
            self.feedSubmissionInfo.messagesSuccessful = Int(string)!
            break
        case "MessagesWithError":
            self.feedSubmissionInfo.messagesWithError = Int(string)!
            break
        case "MessagesWithWarning":
            self.feedSubmissionInfo.messagesWithWarning = Int(string)!
            break
        default:
            //print("\(currentElementName): \(string)")
            break
        }
    }
    
    // BackgroundWorker
    
    private var notify: ((_ feed: RequestFeed) -> Void)!
    private var requests: [RequestFeed] = [RequestFeed]()
    
    public func isSubmitted() -> Bool {
        return self.requests.filter { $0.requestSubmittedAt == 0 }.count == 0
    }
    
    public func start(requests: [RequestFeed]) {
        
        for request in requests {
            if self.requests.first(where: {
                $0.requestSku == request.requestSku && $0.requestFeed.feedType() == request.requestFeed.feedType()
            }) == nil {
                self.requests.append(request)
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            var pendingRequests: [RequestFeed]
            repeat {
                pendingRequests = self.requests.filter { $0.requestCompletedAt == 0 }
                pendingRequests.forEach({ (feed) in
                    self.processFeed(feed)
                    sleep(1)
                })
            } while pendingRequests.count > 0
        }
    }
    
    internal func processFeed(_ request: RequestFeed) {
        
        if request.requestSubmittedAt == 0 {
            
            if request.requestParentId > 0 {
                let parent = requests.first(where: { $0.requestId == request.requestParentId })
                if let parent = parent {
                    if parent.messagesWithError > 0 {
                        request.messagesWithError = parent.messagesWithError
                        request.errorDescription = "request canceled because in error parent"
                        self.notify(request)
                        let index = self.requests.firstIndex { $0.requestId == request.requestId }
                        self.requests.remove(at: index!)
                    }
                    return
                }
            }
            
            self.post(feed: request.requestFeed) { (result) -> (Void) in
                
                if result.feedProcessingStatus == "_SUBMITTED_" {
                    request.requestSubmissionId = result.feedSubmissionId
                    request.requestSubmittedAt = Int.now()
                }
                
                if result.messagesWithError > 0 {
                    request.messagesWithError = result.messagesWithError
                    request.errorDescription = result.errorDescription
                    request.requestSubmittedAt = Int.now()
                    print(request.errorDescription)
                }

                self.notify(request)
            }
            
        } else if request.requestCompletedAt == 0 {
            
            self.result(feedSubmissionId: request.requestSubmissionId) { (result) -> (Void) in
                
                if result.statusCode == "Complete"  {
                    request.messagesProcessed = result.messagesProcessed
                    request.messagesSuccessful = result.messagesSuccessful
                    request.messagesWithError = result.messagesWithError
                    request.messagesWithWarning = result.messagesWithWarning
                    request.errorDescription = result.errorDescription
                    request.requestCompletedAt = Int.now()
                    
                    self.notify(request)
                    let index = self.requests.firstIndex { $0.requestId == request.requestId }
                    self.requests.remove(at: index!)                    
                }
            }
        }
    }
}
