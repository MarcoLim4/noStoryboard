//
//  iTunesViewController.swift
//  TeamIt-NoStoryboard
//
//  Created by Marco Lima on 2021-04-09.
//

import UIKit
import WebKit

class iTunesViewController: UIViewController {

    var url: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        if let theURL = url, let nsURL = URL(string: theURL) {
            
            let webV = WKWebView()
            webV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            webV.load(NSURLRequest(url: nsURL) as URLRequest)
            self.view.addSubview(webV)
            
        } else {
            
            view.backgroundColor = .systemBackground
            
            let noURLLabel = UIObjects.label(fontWeigth: .bold, fontSize: 18)
            view.addSubview(noURLLabel)
            
            noURLLabel.numberOfLines = 0
            noURLLabel.textAlignment = .center
            noURLLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            noURLLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            noURLLabel.text = "Sorry, no iTunes Link for this record!"
            
            
        }
        
    }
    
}
