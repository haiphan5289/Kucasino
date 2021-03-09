//
//  HomeModel.swift
//  KuFun
//
//  Created by paxcreation on 3/9/21.
//

import Foundation

struct HomeModel: Codable {
    let username: Int?
    enum CodingKeys: String, CodingKey {
        case username
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(Int.self, forKey: .username)
    }
}
