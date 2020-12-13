//
//  UIImageViewExtension.swift
//  dotaheroes
//
//  Created by Ahmad Krisman Ryuzaki on 12/12/20.
//  Copyright © 2020 ahmadkrisman. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        AF.request(Constant.baseUrl + urlString, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let responseData = data else {return}
                self.image = UIImage(data: responseData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
