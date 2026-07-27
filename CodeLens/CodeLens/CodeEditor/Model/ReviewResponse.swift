//
//  ReviewResponse.swift
//  MainCodeArea
//
//  Created by Venkatesh Nimmalapudi on 20/07/26.
//

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

//struct IssueDetails: Codable {
//    let testing: [CategoryDetails]
//    let readability: [CategoryDetails]
//    let security: [CategoryDetails]
//    let performance: [CategoryDetails]
//    let maintainability: [CategoryDetails]
//    let correctness: [CategoryDetails]
//    let bestPractices: [CategoryDetails]
//    
//    enum CodingKeys: String, CodingKey {
//        case testing
//        case readability
//        case security
//        case performance
//        case maintainability
//        case correctness
//        case bestPractices = "best_practices"
//    }
//}

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

//extension ReviewResponse {
//    func getIssuesList() -> [String : [CategoryDetails]] {
//        return ["Testing": self.review.issues.testing,
//                "readability": self.review.issues.readability,
//                "security": self.review.issues.security,
//                "performance": self.review.issues.performance,
//                "maintainability": self.review.issues.maintainability,
//                "correctness": self.review.issues.correctness,
//                "bestPractices": self.review.issues.bestPractices]
//    }
//    
//    
//}
