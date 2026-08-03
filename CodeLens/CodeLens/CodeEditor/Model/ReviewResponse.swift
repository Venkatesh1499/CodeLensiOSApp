struct ReviewResponse: Codable {
    let review: ReviewDetails
    let success: Bool
}

struct ReviewDetails: Codable {
    let summary: String
    let improvedCode: String
    let issues: [String : [CategoryDetails]]
    let overallScore: Int
    let severity: SeverityDetails
    
    enum CodingKeys: String, CodingKey {
        case summary
        case improvedCode = "improved_code"
        case issues
        case overallScore = "overall_score"
        case severity
    }
}

struct CategoryDetails: Codable, Hashable {
    let title: String
    let category: String
    let description: String
    let exampleFix: String
    let recommendation: String
    let severity: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case category
        case description
        case exampleFix = "example_fix"
        case recommendation
        case severity
    }
}

struct SeverityDetails: Codable {
    let critical: Int
    let high: Int
    let low: Int
    let medium: Int
}
