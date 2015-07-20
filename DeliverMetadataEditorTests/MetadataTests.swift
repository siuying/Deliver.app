//
//  DeliverMetadataEditorTests.swift
//  DeliverMetadataEditorTests
//
//  Created by Francis Chong on 20/7/15.
//  Copyright © 2015 Ignition Soft. All rights reserved.
//

import XCTest
@testable import DeliverMetadataEditor

import Foundation

class MetadataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDecode() {
        let bundle = NSBundle(forClass: MetadataTests.self)
        if let path = bundle.pathForResource("metadata", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
                    let metadata = try Metadata.decode(json)
                    XCTAssert(metadata.langauges.count > 0, "should have some metadata")
                    
                    XCTAssert(metadata.langauges[.enUS]!.title == "EverClip 2 - Clip everything to Evernote", "should have proper title")
                    XCTAssert(metadata.langauges[.jaJP]!.versionWhatsNew == "ウィジェットからワンタップでクリップする機能が追加された！アプリの起動は一切不要！（Evernote に送信するまで）もうアプリの起動にさようなら！", "should have proper description")

                    return
                } catch {
                    XCTFail()
                }
            }
        }
    }
   
}
