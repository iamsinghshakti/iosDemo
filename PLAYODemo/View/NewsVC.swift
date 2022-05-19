//
//  NewsVC.swift
//  PLAYODemo
//
//  Created by Rapidsoft Technologies on 19/05/22.
//

import UIKit
import WebKit
class NewsVC: UIViewController,WKUIDelegate ,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var url:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        if let ur = url{
       let req = URLRequest(url: URL(string: ur)!)
            Apputility.showLoader(pView: self.view)
            webView.load(req)
        }
        // Do any additional setup after loading the view.
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Apputility.hideLoader(pView: self.view)
    }
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        Apputility.hideLoader(pView: self.view)
      }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
