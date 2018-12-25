//
//  ViewController.swift
//  SwiftJSBridge
//
//  Created by hhfa008 on 06/23/2018.
//  Copyright (c) 2018 hhfa008. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class ViewController: UIViewController {
    
    var webview:WebView?
    var timer:Timer?
    
    @objc func test() -> Void {
        
        self.perform(#selector(test2), on: .main, with: nil, waitUntilDone: false)

    }
    
    @objc func test2(){
        
        _ = self.JSBridge?.callJS(name: "sendMessageToJS", data: ["message":"Hi, I am native"]) { (data) in
            //            print("data")
            //            if let data = data  {
            //                print(data)
            //            }
            //
        }
    }
    
    @objc func test3(){
        _ = webview?.evaluate(javascript: "skr('skr skr')")
    }
    var JSBridge:SwiftJSBridge?
    override func viewDidLoad() {
        super.viewDidLoad()
        webview = getuiwebview()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(test), userInfo: nil, repeats: false)
        view.addSubview((webview?.contentView())!)
        let JSBridge = SwiftJSBridge(for: webview!)
        self.JSBridge = JSBridge
        _ = JSBridge.addSwift(bridge: { (data, cb) in
//            cb?(["appVersion":"1.0"])
            
            self.perform(#selector(self.test3), on: .main, with: nil, waitUntilDone: false)
        }, name: "getAppVersion222")
        
        _ = JSBridge.addSwift(bridge: { (data, cb) in
            //            cb?(["appVersion":"1.0"])
            
            self.perform(#selector(self.test3), on: .main, with: nil, waitUntilDone: false)
        }, name: "getAppVersion")
        
        let path = Bundle.main.path(forResource: "bridge_ly", ofType: "html")
        let file = URL.init(fileURLWithPath: path!)
        
        _ = webview?.loadFileURL(url: file)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getwebview()->WKWebView {
        let config = WKWebViewConfiguration()
        
        let web = WKWebView(frame: self.view.frame, configuration: config)
        return web;
    }
    
    func getuiwebview()->UIWebView {
        let web = UIWebView(frame: self.view.frame)
        return web;
    }
    
    
}


