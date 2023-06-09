//
//  ImageGenerationResponse.swift
//  openaiplatform
//
//  Created by user234729 on 4/9/23.
//

import Foundation

struct ImageGenerationResponse: Codable{
    struct ImageResponse: Codable{
        let url: URL
    }
    
    let created: Int?
    let data: [ImageResponse]
}
