# Parse Chat

![Swift](https://img.shields.io/badge/Swift-3%2B-F05138?logo=swift&logoColor=white)
![iOS 9+](https://img.shields.io/badge/iOS-9%2B-000000?logo=apple&logoColor=white)
![Parse](https://img.shields.io/badge/Backend-Parse-purple)

![Demo](docs/assets/demo2.gif)

iOS chat app backed by Parse SDK. Messages stored in Parse, timeline auto-refreshes on a polling timer.

## Tech

| Layer | Tech |
|---|---|
| Language | Swift |
| UI | UIKit |
| Backend | Parse SDK (CocoaPods) |

## Setup

```bash
git clone https://github.com/gerardrecinto/parse-chat-ios.git
cd parse-chat-ios
pod install
open parseChat.xcworkspace
```

Add your Parse App ID and client key before building.
