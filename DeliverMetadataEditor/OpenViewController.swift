//
//  OpenViewController.swift
//  DeliverMetadataEditor
//
//  Created by Francis Chong on 20/7/15.
//  Copyright © 2015 Ignition Soft. All rights reserved.
//

import Cocoa

class OpenViewController : NSViewController, NSOpenSavePanelDelegate {
    var metadata : Metadata?
    var fileURL : NSURL?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func openFile(_: AnyObject) {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = false
        panel.canCreateDirectories = false
        panel.delegate = self
        
        weak var weakPanel = panel
        panel.beginWithCompletionHandler { (result) -> Void in
            switch result {
            case NSFileHandlingPanelOKButton:
                // open
                if let URL = weakPanel?.URLs.first {
                    self.fileURL = URL

                    do {
                        let data = try NSData(contentsOfURL: URL, options: NSDataReadingOptions(rawValue: 0))
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
                        self.metadata = try Metadata.decode(json)
                        self.performSegueWithIdentifier(MetadataSegue.ShowMetadata.rawValue, sender: nil)

                    } catch {
                        print("error opening file: \(URL) \(error)")
                    }
                    
                    print(URL.absoluteString)
                }
                
            case NSFileHandlingPanelCancelButton:
                // cancelled
                print("cancelled")
            default:
                print("nothing")
            }
        }
    }
    
    /// Segue
    
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if self.metadata == nil || self.fileURL == nil {
                return
            }
            
            if identifier == MetadataSegue.ShowMetadata.rawValue {
                if let controller = segue.destinationController as? EditorViewController {
                    controller.metadata = self.metadata
                    controller.fileURL = self.fileURL
                }
            }
        }
    }

    
    /// NSOpenSavePanelDelegate
    
    func panel(sender: AnyObject, shouldEnableURL url: NSURL) -> Bool {
        return url.absoluteString.pathExtension == "json";
    }
}