//
//  ViewController.swift
//  DeliverMetadataEditor
//
//  Created by Francis Chong on 20/7/15.
//  Copyright © 2015 Ignition Soft. All rights reserved.
//

import Cocoa

class EditorViewController: NSViewController {
    
    // views
    
    @IBOutlet var popupButton: NSPopUpButton!
    @IBOutlet var titleTextField: NSTextField!
    
    @IBOutlet var descriptionTextView: NSTextView!
    @IBOutlet var whatsNewTextView: NSTextView!
    
    @IBOutlet var keywordsTextField: NSTextField!
    @IBOutlet var supportURLTextField: NSTextField!
    @IBOutlet var marketURLTextField: NSTextField!
    @IBOutlet var privacyPolicyURLTextField: NSTextField!

    // data
    var metadata : Metadata? {
        didSet {
            // if metadata is set, set the languages
            if let metadata = self.metadata {
                let languages = metadata.langauges.keys.array.map({ lang in lang.rawValue }).sort()
                self.languages = languages
            }
        }
    }

    var languages : [String]? {
        didSet {
            // if languages is set, set default selected languages
            if let languages = self.languages {
                if languages.count > 0 {
                    self.selectedLanguage = Language(rawValue: languages.first!)
                }
            }
        }
    }
    
    var selectedLanguage : Language? {
        didSet {
            // if metadata and language is set, load the form
            if let metadata = self.metadata , selectedLanguage = self.selectedLanguage {
                self.loadForm(metadata, selectedLanguage: selectedLanguage)
            }
        }
    }

    // when popup button selected item has changed, update the selectedLangauge field
    @IBAction func languageDidChanged(sender: AnyObject) {
        if let selectedItem = self.popupButton.selectedItem {
            if let language = Language(rawValue: selectedItem.title) {
                self.selectedLanguage = language
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // if metadata and language is set, load the form
        if let metadata = self.metadata , selectedLanguage = self.selectedLanguage {
            self.loadForm(metadata, selectedLanguage: selectedLanguage)
        }
    }

    private func loadForm(metadata: Metadata, selectedLanguage: Language) {
        // if the popup button has not been loaded, do not load the form
        if self.popupButton == nil {
            return
        }

        // load languages if availabe
        if let languages = self.languages {
            loadPopupButton(languages)
        }

        // load selected languages
        if let selectedLanguage = self.selectedLanguage {
            if let item = self.popupButton.itemWithTitle(selectedLanguage.rawValue) {
                self.popupButton.selectItem(item)
            }
        }
        
        // load form fields
        if let selectedItem = metadata.langauges[selectedLanguage] {
            self.titleTextField.stringValue = selectedItem.title
            self.descriptionTextView.string = selectedItem.description
            self.whatsNewTextView.string = selectedItem.versionWhatsNew
            self.keywordsTextField.stringValue = selectedItem.keywords.reduce("", combine: { (combined, part) -> String in
                if combined == "" {
                    return part
                } else {
                    return "\(combined),\(part)"
                }
                
            })
            self.marketURLTextField.stringValue = selectedItem.softwareURL
            self.supportURLTextField.stringValue = selectedItem.supportURL
            self.privacyPolicyURLTextField.stringValue = selectedItem.privacyURL
        }
    }

    private func loadPopupButton(languages: [String]) {
        self.popupButton.removeAllItems()
        self.popupButton.addItemsWithTitles(languages)
    }
}

