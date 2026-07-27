import SwiftUI

struct ReviewResultView: View {
    
    @State var shouldNavigateToImporvedCode: Bool = false
    
    var codeReviewResponse: ReviewResponse?
    var issues: [String : [CategoryDetails]] = [:]
    
    var body: some View {
        NavigationStack {
            ZStack {
                //            LinearGradient(colors: [
                //                Color(hex: "#090F15"),
                //                Color(hex: "111827"),
                //                Color(hex: "#141FB2F") //141B2F
                //            ], startPoint: .topLeading,
                //                           endPoint: .bottomTrailing)
                //111827 //151A28
                Color(hex: "#111827").opacity(0.95)
                    .ignoresSafeArea(edges: .all)
                
                VStack {
                    VStack(spacing: 10) {
                        Text("Code Review Result")
                            .foregroundStyle(Color(.gray))
                            .font(.system(size: 18))
                        
                        // TODO: - Need to write a func that determines the severity
                        Image(systemName: codeReviewResponse?.review.overallScore ?? 0 <= 6  ? "exclamationmark.triangle.fill" : "checkmark.circle.fill")
                            .font(.system(size: 72))
                            .foregroundStyle(codeReviewResponse?.review.overallScore ?? 0 <= 6 ? .red : .green)
                        
                        HStack(alignment: .center, spacing: 0) {
                            Text("Overall score is \(String(describing: codeReviewResponse?.review.overallScore ?? 0)) out of 10")
                                .font(.system(size: 24, weight: .medium))
                            //                            .foregroundStyle(codeReviewResponse?.review.overallScore ?? 0 <= 6 ? .red : .green)
                                .foregroundStyle(.white)
                        }
                        
                        Text(codeReviewResponse?.review.summary ?? "The provided code has several issues related to correctness, maintainability, readability, performance, security, and best practices.")
                            .foregroundStyle(Color(.lightText))
                            .font(.system(size: 14, weight: .medium))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    ScrollView {
                        VStack {
                            ForEach(Array(issues), id: \.key) { title, value in
                                CategoryDetailsView(title: title, details: value)
                            }
                        }
                    }.scrollIndicators(.hidden)
                        .edgesIgnoringSafeArea(.bottom)
                    
                    reviewButton
                    
                    Spacer()
                }
                .padding()
            }
            .navigationDestination(isPresented: $shouldNavigateToImporvedCode) {
                ImprovedCodeView(code: codeReviewResponse?.review.improvedCode ?? "",
                                 shouldSelectAll: false,
                                 language: "Python")
            }
        }
    }
    
    private var reviewButton: some View {
        Button {
            shouldNavigateToImporvedCode.toggle()
        } label: {
            HStack(spacing: 15) {
                Spacer()
                Image(systemName: "text.document")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.white)
                
                Text("See improved code")
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .medium))
                    .fontWeight(.medium)
                Spacer()
            }
        }
        .padding()
        .background(Color(hex: "#6048FF"))
        .frame(maxWidth: .infinity, maxHeight: 50)
        .cornerRadius(16)
        .shadow(
            color: Color(hex: "#9A6BFF").opacity(0.35),
            radius: 16
        )
    }
}

struct CategoryDetailsView: View {
    
    var title: String
    var details: [CategoryDetails]
    @State var shouldSelectCode: Bool = false
    @State var dropDownClicked: Bool = false
    @State var code: String = """
"""
    
    init(title: String,
         details: [CategoryDetails]) {
        self.title = title
        self.details = details
        self._code = State(wrappedValue: details[0].exampleFix)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: iconTextMapping[title]?.icon ?? "ladybug")
                    .font(.system(size: 20))
                    .foregroundStyle(iconTextMapping[title]?.color ?? .red)
                    .padding(.horizontal)
                
                Text(iconTextMapping[title]?.title ?? "")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image(systemName: dropDownClicked ? "chevron.down" : "chevron.up")
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    .padding()
            }
            .padding(5)
            .onTapGesture {
                dropDownClicked.toggle()
            }
            .background(
                Color(hex: "#090F15").opacity(0.8),
                in: dropDownClicked ?
                UnevenRoundedRectangle(
                    topLeadingRadius: 12,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 12)
                :
                    UnevenRoundedRectangle(topLeadingRadius: 12,
                                           bottomLeadingRadius: 12,
                                           bottomTrailingRadius: 12,
                                           topTrailingRadius: 12)
            )
            
            if dropDownClicked {
                VStack(spacing: 0) {
                    DetailsView(image: "xmark.circle.fill", title: "Severity", subtitle: details[0].severity, isFromError: true)
                    DetailsView(image: "text.document", title: "Description", subtitle: details[0].description)
                    DetailsView(image: "lightbulb.max", title: "Recomendation", subtitle: details[0].recommendation)
//                    DetailsView(image: "chevron.left.forwardslash.chevron.right", title: "Code", subtitle: details[0].exampleFix)
//                    CodeEditor(text: $code, shouldSelectAll: $shouldSelectCode)
//                        .fixedSize(horizontal: true, vertical: false)
                }
                .padding(10)
                .background(
                    Color(hex: "#111827").opacity(0.9),
                    in: UnevenRoundedRectangle(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 0)/*.stroke(Color.red, lineWidth: 2)*/
                )
            }
        }
    }
}

struct DetailsView: View {

    var image: String
    var title: String
    var subtitle: String
    var isFromError: Bool = false
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundStyle(isFromError ? .red : .blue)
                .padding()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(.blue)
                    .multilineTextAlignment(.leading)
                
                Text(subtitle)
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
    }
}

#Preview {
    ReviewResultView(issues: ["performance": [CodeLens.CategoryDetails(title: "Division Operation", category: "performance", description: "The function uses the \'/\' operator for division, which can be slow for large numbers.", exampleFix: "return a // b or import math; return math.fdiv(a, b)", recommendation: "Consider using the \'//\' operator for integer division or the \'math.fdiv\' function for floating-point division.", severity: "low")], "readability": [CodeLens.CategoryDetails(title: "Syntax Error", category: "syntax error", description: "The function is missing a colon at the end of the function definition.", exampleFix: "def divide(a, b):", recommendation: "Add a colon at the end of the function definition.", severity: "high"), CodeLens.CategoryDetails(title: "Code Formatting", category: "code formatting", description: "The code does not follow PEP 8 code formatting conventions.", exampleFix: "Use consistent indentation and spacing.", recommendation: "Format the code according to PEP 8 conventions.", severity: "low")], "maintainability": [CodeLens.CategoryDetails(title: "Function Name", category: "naming convention", description: "The function name \'divide\' is not descriptive and does not follow PEP 8 naming conventions.", exampleFix: "def divide_numbers(a, b):", recommendation: "Rename the function to something more descriptive, such as \'divide_numbers\'.", severity: "medium"), CodeLens.CategoryDetails(title: "Docstring", category: "documentation", description: "The function is missing a docstring, which makes it difficult for others to understand how to use the function.", exampleFix: "\"\"\"Divide two numbers.\n\nArgs:\n    a (int or float): The dividend.\n    b (int or float): The divisor.\n\nReturns:\n    int or float: The quotient.\"\"\"", recommendation: "Add a docstring to the function.", severity: "medium")], "security": [CodeLens.CategoryDetails(title: "Input Validation", category: "input validation", description: "The function does not validate the inputs, which can lead to security vulnerabilities.", exampleFix: "if not isinstance(a, (int, float)) or not isinstance(b, (int, float)): raise TypeError(\'Inputs must be numbers\')", recommendation: "Add input validation to ensure the inputs are valid and secure.", severity: "high")], "correctness": [CodeLens.CategoryDetails(title: "Division by Zero Error", category: "logic bug", description: "The function does not handle division by zero, which will raise a ZeroDivisionError.", exampleFix: "if b == 0: raise ValueError(\'Cannot divide by zero\')", recommendation: "Add a check to handle division by zero.", severity: "critical"), CodeLens.CategoryDetails(title: "Type Error", category: "type error", description: "The function does not check the type of the inputs, which can lead to a TypeError if the inputs are not numbers.", exampleFix: "if not isinstance(a, (int, float)) or not isinstance(b, (int, float)): raise TypeError(\'Inputs must be numbers\')", recommendation: "Add type checking to ensure the inputs are numbers.", severity: "high")], "testing": [CodeLens.CategoryDetails(title: "Unit Tests", category: "unit tests", description: "The function is missing unit tests, which makes it difficult to ensure the function is working correctly.", exampleFix: "import unittest; class TestDivideFunction(unittest.TestCase): def test_divide(self): self.assertEqual(divide(10, 2), 5)", recommendation: "Add unit tests to the function.", severity: "medium")], "best_practices": [CodeLens.CategoryDetails(title: "Error Handling", category: "error handling", description: "The function does not handle errors properly, which can lead to unexpected behavior.", exampleFix: "try: return a / b; except ZeroDivisionError: raise ValueError(\'Cannot divide by zero\'); except TypeError: raise TypeError(\'Inputs must be numbers\')", recommendation: "Add try-except blocks to handle errors and exceptions.", severity: "medium")]])
}

struct IconMappingDetails {
    let title: String
    let icon: String
    let color: Color
}

let iconTextMapping: [String : IconMappingDetails] = [
    "best_practices": IconMappingDetails(title: "Best practices", icon: "medal.star", color: .green),
    "testing": IconMappingDetails(title: "Testing", icon: "flask", color: Color(.indigo)),
    "performance": IconMappingDetails(title: "Performance", icon: "powermeter", color: .purple),
    "maintainability": IconMappingDetails(title: "Maintainability", icon: "wrench.adjustable", color: .yellow),
    "readability": IconMappingDetails(title: "Readability", icon: "book", color: .blue),
    "correctness": IconMappingDetails(title: "Correctness", icon: "ladybug", color: .red),
    "security": IconMappingDetails(title: "Security", icon: "lock", color: .red)
]
