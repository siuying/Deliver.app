//
//  ViewController.swift
//  DeliverMetadataEditor
//
//  Created by Francis Chong on 20/7/15.
//  Copyright © 2015 Ignition Soft. All rights reserved.
//

import Cocoa

class EditorViewController: NSViewController {

    @IBOutlet var popupButton: NSPopUpButton!
    @IBOutlet var titleTextField: NSTextField!
    
    @IBOutlet var descriptionTextView: NSScrollView!
    @IBOutlet var whatsNewTextView: NSScrollView!
    
    @IBOutlet var keywordsTextField: NSTextField!
    
    @IBOutlet var supportURLTextField: NSTextField!
    @IBOutlet var marketURLTextField: NSTextField!
    @IBOutlet var privacyPolicyURLTextField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func loadForm() {
    }
    
    
}

