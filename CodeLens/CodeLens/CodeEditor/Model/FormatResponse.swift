//
//  FormatResponse.swift
//  MainCodeArea
//
//  Created by Venkatesh Nimmalapudi on 20/07/26.
//

struct FormatResponse: Codable {
    let error: String?
    let formattedCode: String?
    
    init(error: String? = nil, formattedCode: String? = nil) {
        self.error = error
        self.formattedCode = formattedCode
    }
}
