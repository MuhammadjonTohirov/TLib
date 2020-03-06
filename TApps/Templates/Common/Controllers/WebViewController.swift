//
//  WebViewController.swift
//  uzcard trade
//
//  Created by Muhammadjon Tohirov on 12/6/19.
//  Copyright © 2019 Plum Technologies. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    private var webView = WKWebView()

    private var webURL: String
    
    private var url: URL?
    
    private let navigationView: UIView = UIView()
    
    private let backButton = UIButton()
    
    private let shareButton = UIButton()
    
    private let titleLabel = UILabel()
    
    private var isDocument: Bool = false
    private var documentName: String = ""

    init(_ webURL: String) {
        self.webURL = webURL
        isDocument = webURL.substringFromIndex(webURL.count - 4) == ".pdf"
        documentName = webURL.split("/").last ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(url: URL) {
        self.init(url.absoluteString)
        self.url = url
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = "Loading ..."
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = theme.labelColor
        
        let refreshItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        refreshItem.tintColor = .black

        
        self.view.addSubview(navigationView)

        backButton.setImage(#imageLiteral(resourceName: "icon_left_arrow").changeColor(theme.iconColor2), for: .normal)
        backButton.onClick(self, #selector(onClickBack))
        self.navigationView.addSubview(backButton)
        self.navigationView.addSubview(titleLabel)
        self.navigationView.addSubview(shareButton)
        
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        webView.subviews.forEach { (view) in
            view.backgroundColor = theme.backgroundColor
        }
        shareButton.isHidden = true
        shareButton.onClick(self, #selector(shareDocumentAction))
        
        load()
    }
    
    @objc func shareDocumentAction() {
        self.shareDocument()
    }
    
    @objc func onClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func shareDocument() {
        let u = URL(string: webURL)
        
        let objectsToShare = [u]
        let activityVC = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.backgroundColor = theme.backgroundColor
        self.view.backgroundColor = theme.backgroundColor
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        navigationView.backgroundColor = theme.backgroundColor
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view.size.width, height: CGFloat(44) + CGFloat(self.topSafe))
        
        let y = navigationView.height - 30 - 7
        backButton.frame = CGRect(x: 8, y: y, width: 30, height: 30)
        
        let w: CGFloat = 100
        let x: CGFloat = (navigationView.width - w) / 2
        titleLabel.frame = CGRect(x: x, y: y, width: w, height: 30)
        
        shareButton.frame = backButton.frame
        shareButton.x = navigationView.width - shareButton.width - 8
        
        webView.frame = CGRect(x: 0, y: navigationView.maxY, width: self.view.size.width, height: self.view.size.height - navigationView.maxY)
    }

    private func load() {
        if let unwrappedURL = self.url ?? URL(string: webURL) {
            let urlRequest = URLRequest(url: unwrappedURL)
            if self.isDocument {
                do {
                    let data = try Data(contentsOf: unwrappedURL)
                    webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: unwrappedURL.deletingLastPathComponent())

                } catch let error {
                    logger.log(message: "error \(error.localizedDescription)")
                }
                return
            }
            webView.load(urlRequest)
        }
    }

}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.titleLabel.text = webView.title
        if self.isDocument {
            self.titleLabel.text = self.documentName
            self.shareButton.isHidden = false
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        self.alertInfo(title: "error".localized, message: error.localizedDescription, handler: { (_) in
//            self.navigationController?.popViewController(animated: true)
//        })
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        self.alertInfo(title: "error".localized, message: error.localizedDescription, handler: { (_) in
//            self.navigationController?.popViewController(animated: true)
//        })
    }
}

