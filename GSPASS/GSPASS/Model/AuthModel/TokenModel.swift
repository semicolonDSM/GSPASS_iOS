//
//  LoginModel.swift
//  GSPASS
//
//  Created by 김수완 on 2021/05/29.
//

import Foundation

struct TokenModel: Codable {
    let accessToken: String
    let refreshToken: String
}
