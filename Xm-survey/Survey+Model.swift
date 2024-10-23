//
//  Survey+Model.swift
//  Xm-survey
//
//  Created by Veljko Bogdanovic on 23.10.24..
//

import Foundation
import SwiftUI

public struct Question: Equatable, Identifiable, Codable {
    public let id: Int
    let question: String?
    var answer: String?
    var submitted: Bool?
}
