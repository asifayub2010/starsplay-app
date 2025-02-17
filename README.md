# Stars Play

## Overview
Stars Play is an iOS application that provides TV show details, lists, and season information using a modularized architecture. The project is built using Swift and integrates a custom `NetworkClient` framework for API requests.

## Features
- Fetch TV show details
- Retrieve a list of popular TV shows
- Get season details for a specific show
- Modular architecture with a separate networking layer

## Requirements
- Xcode 15 or later
- iOS 15.0+
- Swift 5.0+

## Installation
### Manual Integration
1. Clone this repository:
   ```sh
   git clone https://github.com/asifayub2010/starsplay-app.git
   ```
2. Open `Stars Play.xcodeproj` in Xcode.
3. Ensure `NetworkClient.framework` is added to `Frameworks, Libraries, and Embedded Content`.
4. Build and run the project.

## Usage
### Dependency Injection in SwiftUI
To use `APIService` within SwiftUI:
```swift
@main
struct Stars_PlayApp: App {
    let apiService = APIService(apiKey: "your_api_key", baseURL: "https://api.example.com")

    var body: some Scene {
        WindowGroup {
            TVShowListView(apiService: apiService)
                .preferredColorScheme(.dark)
        }
    }
}
```

### Fetching TV Shows
```swift
let apiService = APIService(apiKey: "your_api_key", baseURL: "https://api.example.com")
Task {
    do {
        let shows = try await apiService.fetchTVShowsList()
        print(shows)
    } catch {
        print("Error fetching shows: \(error)")
    }
}
```

## Project Structure
```
Stars Play
│── Generals
│   ├── Constants.swift
│   ├── Network
│       ├── APIService.swift
│── Views
│   ├── TVShowListView.swift
│── NetworkClient.framework
│── Stars Play.xcodeproj
│── README.md
```

## License
This project is licensed under the MIT License. See `LICENSE` for details.

## Contact
For questions or contributions, feel free to open an issue or reach out at `asifayub2010@gmail.com`.

