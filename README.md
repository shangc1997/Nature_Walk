# Group Nature Walk Project

Group Nature Walk Project is a SwiftUI iOS group assignment for the Introduction to iOS Development course. The app lets:

- Users sign in
- Browse available group sessions
- View session details
- Contact the host
- Share session information
- Manage a personal favorites list

## Team Members

- Chuhan Shang
- Bishakha

## Course Information

- Course Name: Introduction to iOS Development
- Semester: Spring/Summer 2026

## Project Overview

The app starts on `LoginView` and moves into a tab-based main interface after a successful login. The main interface is built in `ContentView` and contains three sections:

- `SessionView`
- `FavoritesView`
- `ProfileView`

The project currently uses hard-coded sample users and sessions to demonstrate the required app flow.

## Current Features

### Login Flow

- Login screen with email and password fields
- Remember Me toggle
- Validation for empty email and password fields
- Two sample accounts for authentication:
  - `test@gmail.com` / `test123`
  - `admin@gmail.com` / `admin123`
- App launches to the login screen
- Remembered credentials are restored on launch when Remember Me was enabled
- Remember Me does not auto-enter the main app
- Logout returns the user to the login screen

### Sessions

- Session list screen built in `SessionView`
- At least 3 hard-coded sessions managed by `SessionViewModel`
- Each list item shows:
  - session photo
  - session name
  - price per person
- Tapping a session opens `DetailSessionView`

### Session Details

- Session name
- Price per person
- Star rating
- Two photos
- Session description
- Guide / organization name
- Host phone number
- Tap-to-call behavior using the iOS phone dialer
- Share sheet support for sharing the session name and price
- Add to Favorites / Favorited button state

### Favorites

- User-specific favorites list in `FavoritesView`
- Add and remove favorites from the detail screen
- Remove a single favorite with swipe actions
- Remove all favorites with the toolbar action
- Favorites are filtered by the currently logged-in user

### Profile

- Displays the current user's name and email
- Logout button

## Data Persistence

The app uses `UserDefaults` to persist:

- Remember Me state
- Remembered email
- Remembered password
- Saved user data
- Each user's favorite session IDs
- The most recently persisted logged-in user identity

## Technologies Used

- Swift 5
- SwiftUI
- Observation framework (`@Observable`)
- Xcode
- Git and GitHub

## Project Structure

```text
Group_Nature_Walk_Project/
├── .gitignore
├── Group_Nature_Walk_Project/
│   ├── Assets.xcassets/
│   ├── Model/
│   │   ├── Session.swift
│   │   └── User.swift
│   ├── View/
│   │   ├── ContentView.swift
│   │   ├── DetailSessionView.swift
│   │   ├── FavoritesView.swift
│   │   ├── LoginView.swift
│   │   ├── ProfileView.swift
│   │   ├── SessionListItem.swift
│   │   └── SessionView.swift
│   ├── ViewModel/
│   │   ├── SessionViewModel.swift
│   │   └── UserViewModel.swift
│   └── Group_Nature_Walk_ProjectApp.swift
├── Group_Nature_Walk_Project.xcodeproj/
│   ├── project.pbxproj
│   └── project.xcworkspace/
│       └── contents.xcworkspacedata
└── README.md
```

## How to Run the Project

1. Clone this repository.
2. Open `Group_Nature_Walk_Project.xcodeproj` in Xcode.
3. Select an iPhone simulator or a real device.
4. Build and run the app.

## Development Notes

- Session data is currently hard-coded in `SessionViewModel`
- Sample user accounts are currently defined in `UserViewModel`
- Favorites persistence depends on stable session IDs in the sample data
- Remember Me data is stored locally for coursework demonstration purposes
