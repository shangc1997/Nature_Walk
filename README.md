# Group Nature Walk Project

Group Nature Walk Project is a SwiftUI iOS group assignment for the Introduction to iOS Development course.

The app is being built to allow users to:

- log in with an email address and password
- browse available nature walk sessions
- open a detail page for each session
- contact the guide or organization by phone number
- share session information
- manage a favorites list

## Team Members

- Chuhan Shang
- Bishakha

## Course Information

- Course Name: Introduction to iOS Development
- Semester: Spring/Summer 2026

## Project Summary

The current app is structured around a tab-based interface in `ContentView` with three main areas:

- `SessionView`
- `FavoritesView`
- `ProfileView`

The project also includes a `LoginView`, but it is still a placeholder and is not yet connected to the app launch flow.

## Current Features

### Completed

- Main screen in `ContentView`
  - Includes 3 tabs: `SessionView`, `FavoritesView`, and `LogoutView`
- Session list screen in `SessionView`
  - Displays available nature walk sessions
  - Shows session photo, name, and price per person
  - Navigates to `DetailSessionView` when a session is selected
- Session details screen in `DetailSessionView`
  - Displays the chosen session name
  - Displays star rating
  - Displays price per person
  - Displays description
  - Displays host / organization name
  - Displays host phone number
  - Opens the phone dialer when the phone number is tapped
  - Opens the iOS sharing widget and shares the session name and price
- Sample session data managed by `SessionViewModel`

### In Progress

- Session details screen in `DetailSessionView`
  - Block 1 completed: name, star rating, and price per person
  - Block 2 not completed: 2 photos
  - Block 3 completed: description
  - Block 4 completed: host / organization name and phone number
  - Block 5 completed: favorites button and share button UI
  - Favorites button behavior is not completed yet

### Planned / TODO

- `LoginView`
  - Create a `User` model to store user information
  - Build the actual login screen
  - Add form validation
  - Add a Remember Me checkbox
  - Auto-fill email and password if Remember Me was selected
  - Navigate to `ContentView` after successful login
- `FavoritesView`
  - View the favorites list
  - Remove a single favorited session
  - Remove all favorited sessions
- `LogoutView`
  - Display user information
  - Add a logout button
  - Return the user to the login screen

## Screens

- `LoginView` (placeholder)
- `SessionView`
- `DetailSessionView` (in progress)
- `FavoritesView` (placeholder)
- `ProfileView` (placeholder)

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
│   │   └── Session.swift
│   ├── View/
│   │   ├── ContentView.swift
│   │   ├── DetailSessionView.swift
│   │   ├── FavoritesView.swift
│   │   ├── LoginView.swift
│   │   ├── LogoutView.swift
│   │   ├── SessionListItem.swift
│   │   └── SessionView.swift
│   ├── ViewModel/
│   │   └── SessionViewModel.swift
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

- The app currently launches directly into `ContentView`
- Session data is hard-coded in `SessionViewModel`
- Update this README when new features are completed.
