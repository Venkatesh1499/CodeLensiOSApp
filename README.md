# CodeLens iOS App

An AI-powered iOS application that helps developers understand, analyze, format, and improve source code directly from their iPhone. CodeLens combines a modern native iOS experience with Large Language Models (LLMs) and intelligent backend services to provide code explanations, optimization suggestions, formatting, and best practices across multiple programming languages.

---

# ✨ Features

### 🤖 AI-Powered Code Analysis

* Analyze source code using Large Language Models (LLMs).
* Identify potential bugs, code smells, and performance issues.
* Receive intelligent suggestions to improve code quality and maintainability.

### 📖 AI Code Explanation

* Generate human-readable explanations for complex code snippets.
* Understand functions, classes, algorithms, and programming concepts instantly.
* Helpful for both beginners and experienced developers.

### 🌐 Multi-Language Support

CodeLens supports analyzing code written in multiple programming languages, making it useful for developers working across different technology stacks.

Examples include:

* Swift
* Python
* Java
* C++
* JavaScript
* TypeScript
* Kotlin
* Go
* Rust
* And many more supported by the integrated LLM.

### 🎨 Intelligent Code Formatting

* Format source code using a dedicated formatting API.
* Improve code readability with consistent indentation and styling.
* Instantly convert poorly formatted code into clean, professional code.

### 💡 AI Code Improvements

* Generate optimization suggestions.
* Improve readability and maintainability.
* Recommend coding best practices.
* Suggest cleaner and more efficient implementations.

### 📱 Native iOS Experience

* Built using **SwiftUI** and **UIKit**.
* Responsive and intuitive user interface.
* Smooth animations and reusable UI components.

### 🔐 Secure Authentication

* Firebase Authentication for secure sign-in.
* User account management.
* Protected access to AI-powered features.

### ☁️ Cloud Integration

* Firebase integration for user data and cloud services.
* Secure communication between the mobile application and backend APIs.

---

# 🏗 Architecture

The application follows the **MVVM** architecture for clean code organization and maintainability.

```text
SwiftUI / UIKit
        │
      Views
        │
    ViewModels
        │
 Repository Layer
        │
 Flask REST APIs
        │
 ┌───────────────┐
 │ Formatting API│
 └───────────────┘
        │
 ┌───────────────┐
 │ LLM Services  │
 └───────────────┘
        │
    Firebase
```

---

# 🛠 Tech Stack

## iOS

* Swift
* SwiftUI
* UIKit
* MVVM Architecture

## Backend

* Python
* Flask
* REST APIs

## AI

* Large Language Models (LLMs)

## Cloud

* Firebase Authentication
* Firebase Firestore
* Firebase Storage (if applicable)

---

# 🚀 Workflow

1. User enters or pastes source code.
2. Selects the desired operation:
   * Code Review
   * Format Code
3. The iOS application sends the request to the Flask backend.
4. The backend communicates with the appropriate service:
   * LLM for code review, analysis and to get the improved code.
   * Formatting API for code formatting.
5. The processed result is returned and displayed in the app with a clean, user-friendly interface where user can see the improved code and copy or share it via multiple mediums.

---

# 🎯 Why CodeLens?

CodeLens simplifies the way developers interact with source code by combining AI-powered analysis with professional formatting tools in a single native iOS application. Whether you're learning a new language, debugging existing code, or improving code quality, CodeLens provides intelligent assistance in just a few taps.

---

# 📸 Screenshots

Add screenshots showcasing:

* Home Screen
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-08-05 at 07 56 57" src="https://github.com/user-attachments/assets/1091bb5c-534f-4477-aa54-c0a44d115cf5" />
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-08-05 at 07 58 03" src="https://github.com/user-attachments/assets/e659a4dd-021b-4d1c-b501-8d5e1f1bc8b5" width="220"/>

* Multi-language Selection
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-08-05 at 07 58 50" src="https://github.com/user-attachments/assets/363b1761-eef6-40a2-96bc-5112d4d3e897" width="220"/>

* Code Input
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-08-05 at 07 59 11" src="https://github.com/user-attachments/assets/86a311f3-75f1-4b9b-b609-3cec52c6511b" width="220"/>

* AI Analysis
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-08-05 at 07 59 58" src="https://github.com/user-attachments/assets/693f708d-d6d8-4542-a920-2bb74afe7bd2" width="220"/>

* Improved code
<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-08-05 at 08 00 08" src="https://github.com/user-attachments/assets/5502c4cb-fbd5-4e28-8f4b-88932ee76a2c" width="220"/>


---

# 👨‍💻 Author

**Venkatesh**

If you found this project useful, consider giving it a ⭐ on GitHub!
