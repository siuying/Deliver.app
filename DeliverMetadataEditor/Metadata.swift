//
//  Metadata.swift
//  DeliverMetadataEditor
//
//  Created by Francis Chong on 20/7/15.
//  Copyright © 2015 Ignition Soft. All rights reserved.
//

import Foundation
import Decodable

/// error parsing metadata
enum MetadataError: ErrorType {
    case InvalidJSON
}

/// app metadata for a language
struct MetadataItem {
    var title : String
    var description : String
    var versionWhatsNew : String

    var softwareURL : String
    var supportURL : String
    var privacyURL : String
    var keywords : [String]
}

struct Metadata {
    var langauges : [Language:MetadataItem]
    
    init(languages theLanguages: [Language:MetadataItem]) {
        self.langauges = theLanguages
    }
}

extension MetadataItem : Decodable {
    static func decode(j: AnyObject) throws -> MetadataItem {
        return try MetadataItem(
            title: j => "title",
            description: j => "description",
            versionWhatsNew: j => "version_whats_new",
            softwareURL: j => "software_url",
            supportURL: j => "support_url",
            privacyURL: j => "privacy_url",
            keywords: j => "keywords"
        )
    }
}

extension Metadata {
    static func decode(j: AnyObject) throws -> Metadata {
        if let dictionary = j as? NSDictionary {
            var metadataValues : [Language:MetadataItem] = [:]
            for (key , value) in dictionary {
                if let key = key as? NSString, value = value as? NSDictionary {
                    if let language = Language(rawValue: key as String) {
                        let item = try MetadataItem.decode(value)
                        metadataValues[language] = item
                    }
                }
            }
            return Metadata(languages: metadataValues)
        }
        
        throw MetadataError.InvalidJSON
    }
}

// equatable

func == (lhs: MetadataItem, rhs: MetadataItem) -> Bool {
    return lhs.title == rhs.title && lhs.description == rhs.description
}

extension MetadataItem: Equatable {
    var hashValue: Int { return description.hashValue ^ title.hashValue }
}