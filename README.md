# Group Nature Walk Project

Group Nature Walk Project is a SwiftUI iOS group assignment for the Introduction to iOS Development course.

The app allows users to:

- browsing available guided activity sessions
- opening a detail page for each session
- contacting the guide or organization by phone number
- marking a session to favorites
- sharing session information

## Team Members

- Chuhan Shang
- Bishakha

## Course Information

- Course Name: Introduction to iOS Development
- Semester: Spring/Summer 2026

## Project Summary

The current app is structured around a tab-based interface in `ContentView`:

- `Sessions`
- `Favorites`
- `Logout`

The project also includes a `LoginView`, but it is still a placeholder and is not yet connected to the app launch flow.

## Current Features

### Completed

- Session list screen in `SessionView`
  - Displays session image, name, and price
  - Navigates to `DetailSessionView` when a session is selected
- Session detail screen in `DetailSessionView`
  - Displays session name
  - Displays star rating
  - Displays description
  - Displays host or organization name
  - Displays host phone number
  - Displays price per person
  - Opens the phone dialer with `tel://`
  - Lets the user add or remove a session from favorites
  - Lets the user share the session name and price with `ShareLink`
- Sample session data managed by `SessionViewModel`
- Tab bar navigation with `Sessions`, `Favorites`, and `Logout`

### In Progress

- The detail screen includes a `Photos` section, but the photo gallery UI is not finished yet
- Favorite state can be toggled from the detail screen, but `FavoritesView` is still only a placeholder

### Planned / TODO

- `LoginView`
  - Build the actual login screen
  - Redirect successful login to `ContentView`
- `FavoritesView`
  - Show the favorites list
  - Remove a single saved session
  - Remove all saved sessions
- `LogoutView`
  - Add a logout button
  - Return the user to the login screen

## Screens

- `LoginView` (placeholder)
- `SessionView`
- `DetailSessionView`
- `FavoritesView` (placeholder)
- `LogoutView` (placeholder)

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
- The README has been aligned with the current source code and the feature checklist described in `Project.docx`
- Update this README when new features are completed.
