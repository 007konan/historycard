//
//  ShareViewController.swift
//  powerpointtarget
//
//  Created by 藤田一貴 on 2019/11/04.
//  Copyright © 2019 kazuki fujita. All rights reserved.
//

import UIKit
import MobileCoreServices
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:1.0, green:0.75, blue:0.5, alpha:1.0)

        // postName
        let controller: UIViewController = self.navigationController!.viewControllers.first!
        controller.navigationItem.rightBarButtonItem!.title = "保存"
    }
    
    override func didSelectPost() {
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
