/*******************************************************************************
 * Copyright (c) 2023
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *******************************************************************************/

import UIKit
import WebKit
import SwiftUI

struct LocalWebView: UIViewRepresentable{

    @Binding var reload: Bool

    private let webview = WKWebView()

    fileprivate func loadRequest(in webView: WKWebView) {
        
        if let htmlPath = Bundle.main.path(forResource: "Resource/cabot_map", ofType: "html"),
            let baseUrl = Bundle.main.resourceURL?.appendingPathComponent("Resource") {
            do {
                let htmlString = try NSString(contentsOfFile: htmlPath, encoding: String.Encoding.utf8.rawValue)
                webView.loadHTMLString(htmlString as String, baseURL: baseUrl)
            } catch {
            }
            webView.isOpaque = false
            webView.isHidden = false
        }
    }

    func makeUIView(context: UIViewRepresentableContext<LocalWebView>) -> WKWebView {
        UIApplication.shared.isIdleTimerDisabled = true
        loadRequest(in: webview)
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<LocalWebView>) {
        if reload {
            loadRequest(in: uiView)
            DispatchQueue.main.async {
                self.reload = false
            }
        }
    }
}
