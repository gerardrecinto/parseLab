# Parse Chat Lab

![Swift](https://img.shields.io/badge/Swift-3%2B-F05138?logo=swift&logoColor=white)
![iOS 9+](https://img.shields.io/badge/iOS-9%2B-000000?logo=apple&logoColor=white)
![Parse](https://img.shields.io/badge/Backend-Parse-purple)

iOS real-time chat app built with Swift and the Parse SDK. Messages are stored in Parse and the chat timeline auto-refreshes on a polling timer.

## Tech

| Layer | Tech |
|---|---|
| Language | Swift |
| UI | UIKit |
| Backend | Parse SDK (CocoaPods) |

## Setup

```bash
git clone https://github.com/gerardrecinto/parseLab.git
cd parseLab
pod install
open parseChat.xcworkspace
```

Add your Parse App ID and client key to the project before building.
