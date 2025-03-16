//
//  WebKitView.swift
//  PerfectFit
//
//  Created by Mann Fam on 3/16/25.
//

import SwiftUI
import WebKit
import Foundation

struct WebKitView: UIViewRepresentable {
    
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> some UIView {
        let webview = WKWebView()
        webview.load(URLRequest(url: url))
        return webview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
