//
//  CellData.swift
//  PryanikyTestTask
//
//  Created by Melalujka on 01.10.2020.
//  Copyright © 2020 Melalujka. All rights reserved.
//

import Foundation

struct CellData: Codable {
    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [Variant]?
}
