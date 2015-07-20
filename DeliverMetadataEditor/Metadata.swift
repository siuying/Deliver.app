//
//  Metadata.swift
//  DeliverMetadataEditor
//
//  Created by Francis Chong on 20/7/15.
//  Copyright © 2015 Ignition Soft. All rights reserved.
//

import Foundation

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
    var langauges : [Languages:MetadataItem]
}
