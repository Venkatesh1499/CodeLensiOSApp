struct FormatResponse: Codable {
    let error: String?
    let formattedCode: String?
    
    init(error: String? = nil, formattedCode: String? = nil) {
        self.error = error
        self.formattedCode = formattedCode
    }
}
