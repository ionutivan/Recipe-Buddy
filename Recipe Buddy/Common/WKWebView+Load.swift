//
//  WKWebView+Load.swift
//  Recipe Buddy
//
//  Created by Ionut Ivan on 29/01/2020.
//  Copyright © 2020 Ionut Ivan. All rights reserved.
//

import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
