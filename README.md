# Survey

**Description**

This project demonstrates the use of **The Composable Architecture (TCA)** in a simple SwiftUI application. The app begins with an initial screen where a `Store` is injected, which connects the state, actions, models, and reducer logic to the UI.

## TCA Version

This project uses **TCA version 1.15**, which introduces macros, simplifying code compared to previous versions. The new syntax reduces boilerplate and makes the code easier to read and maintain.

## Features

- Two screens: An initial screen to start the survey and a question screen that displays a horizontal pager of survey questions.
- The ability to navigate between questions and submit answers.
- Local in-memory state tracking of submitted questions.
- Submission of answers to a server and dynamic display of submission success or failure messages.
- Use of modern Swift and SwiftUI patterns, including `async/await` for networking and state management with TCA.

## Unit Tests

This project utilizes **Swift Testing** to validate business logic. It uses **TestStore** from TCA to test reducer actions.

## Endpoints

- **GET** `BASE URL/questions`: Retrieves a list of survey questions.
- **POST** `BASE URL/question/submit`: Submits an answer for a specific question.

## How to Run

1. Clone the repository.
2. Open the project in Xcode.
3. Run the app on a simulator or a connected device.
4. Execute unit tests by selecting `Product > Test` in Xcode.

## Installation

To integrate dependencies like TCA, use **Swift Package Manager**:

```bash
https://github.com/pointfreeco/swift-composable-architecture
