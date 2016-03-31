//
//  SqureWebViewController.swift
//  百思不得其姐
//
//  Created by yangtao on 3/23/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import NJKWebViewProgress

class SqureWebViewController: UIViewController {

    @IBOutlet weak var webView:UIWebView!
    @IBOutlet weak var goBackItem:UIBarButtonItem!
    @IBOutlet weak var progressView:UIProgressView!
    @IBOutlet weak var goForwardItem:UIBarButtonItem!
    
    var webUrl:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("urlurlurlurl=======\(webUrl)")
        webView.delegate = progress
        progress.progressBlock = {
            (progress:Float) in
            
            self.progressView.progress = progress
            self.progressView.hidden = (progress == 1.0)
        }
        
        progress.webViewProxyDelegate = self
            
            let requesturl = NSURL(string: webUrl)
            let request = NSURLRequest(URL: requesturl!)
                 webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private lazy var progress:NJKWebViewProgress =  {
    
        let progress = NJKWebViewProgress()
        return progress
    }()

    @IBAction func goBack(sender: AnyObject) {
        webView.goBack()
    }
    @IBAction func goForward(sender: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func refresh(sender: AnyObject) {
        webView.reload()
    }
}

extension SqureWebViewController:UIWebViewDelegate {

    func webViewDidFinishLoad(webView: UIWebView) {
     
      goBackItem.enabled = webView.canGoBack;
       goForwardItem.enabled = webView.canGoForward;
    }
}
