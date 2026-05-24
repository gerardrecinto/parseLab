# Parse Chat

![Swift](https://img.shields.io/badge/Swift-6.0-F05138?logo=swift&logoColor=white)
![iOS 16+](https://img.shields.io/badge/iOS-16%2B-000000?logo=apple&logoColor=white)
![Parse](https://img.shields.io/badge/Backend-Parse-purple)
![UIKit](https://img.shields.io/badge/UIKit-UITableView-lightgrey)
![CocoaPods](https://img.shields.io/badge/CocoaPods-Parse-red)

![Demo](docs/assets/demo2.gif)

> Multi-user iOS chat app where messages are stored as `PFObject` instances in a Parse class, fetched with a `PFQuery` sorted descending on `createdAt`, and refreshed on a 5-second `Timer` so the conversation stays current without a persistent socket connection.

## Features

- **PFUser Registration and Login:** `SignUpViewController` creates a `PFUser` and calls `signUpInBackground`; `LoginViewController` calls `PFUser.logInWithUsername(inBackground:password:)`. Both present a `UIAlertController` for error feedback on failure.
- **Polling-Based Message Refresh:** `ChatViewController` schedules a repeating `Timer` with `timeInterval: 5` on `viewDidLoad`; each tick calls `getMessages()`, which fires a `PFQuery.findObjectsInBackground` and reloads the `UITableView` with the latest data.
- **Parse Query with Sort:** `PFQuery(className:)` applies `addDescendingOrder("createdAt")` and `includeKey("user")` so the user pointer is resolved server-side in one round-trip, avoiding N+1 fetches.
- **Message Send:** Tapping the send button creates a new `PFObject`, sets the `"text"` key from the `UITextField`, and calls `saveInBackground`; the completion block confirms persistence before the next poll picks it up.
- **UIRefreshControl:** A `UIRefreshControl` is inserted into the table at subview index 0 and wired to `onRefresh`, giving users a manual pull-to-refresh in addition to the automatic polling.
- **Input Validation:** Both auth view controllers guard against empty username and password fields with a `UIAlertController` before attempting any network call.

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Swift 6.0 |
| UI | UIKit, UITableView, UIAlertController, Auto Layout |
| Backend | Local in-memory store|
| Polling | `Timer.scheduledTimer(timeInterval:target:selector:userInfo:repeats:)` |
| Auth | PFUser `signUpInBackground` / `logInWithUsername(inBackground:)` |
| Dependencies | CocoaPods — Parse |

## Architecture

The app has three view controllers connected in a storyboard: `LoginViewController` (entry point), `SignUpViewController` (modal or pushed from login), and `ChatViewController` (the main screen after authentication). `ChatViewController` owns `msgs: [PFObject]` as its data source and is the sole `UITableViewDataSource` and `UITableViewDelegate`. Parse is initialized in `AppDelegate.application(_:didFinishLaunchingWithOptions:)` using `ParseClientConfiguration` with `applicationId` and `server` URL before any view controller loads.

## Key Implementation

**5-second polling loop:** `Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)` is created in `viewDidLoad`; `onTimer` delegates to `getMessages()`, which replaces `self.msgs` and calls `tableView.reloadData()` on the main queue via the Local in-memory store