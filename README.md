# Group Nature Walk Project

## Project Overview

Group Nature Walk Project is an iOS app built with SwiftUI for a school group assignment.

The app allows users to:

- browse available sessions
- view session details
- see session price and star rating
- call the guide or organization by phone number
- add a session to favorites
- share session name and price

## Team Members

- Chuhan Shang
- Bishakha

## Course Information

- Course Name: Introduction to iOS Development
- Semester: Spring/Summer 2026

## Current Features

- Session list screen with image, name, and price
- Session details screen with:
  - session name
  - description
  - star rating
  - host name
  - host phone number
  - price per person
  - favorites button
  - share button
- Phone call support using `tel://`
- Tab bar navigation

## Current Screens

- Sessions
- Session Details
- Favorites
- Logout

## Development Status

- `SessionView`: implemented
- `DetailSessionView`: implemented
- `SessionViewModel`: implemented with `@Observable`
- `FavoritesView`: basic placeholder, can be expanded
- `LoginView`: placeholder
- `LogoutView`: placeholder

## Technologies Used

- Swift
- SwiftUI
- Observation framework (`@Observable`)
- Xcode
- Git and GitHub

## Project Structure

```text
Group_Nature_Walk_Project/
├── Group_Nature_Walk_Project/
│   ├── Assets.xcassets/
│   ├── Model/
│   ├── View/
│   ├── ViewModel/
│   └── Group_Nature_Walk_ProjectApp.swift
├── Group_Nature_Walk_Project.xcodeproj/
└── README.md
```

## How to Run the Project

1. Clone this repository.
2. Open `Group_Nature_Walk_Project.xcodeproj` in Xcode.
3. Select an iPhone simulator or a real device.
4. Press `Run` in Xcode.

## Collaboration Workflow

- Use `main` as the shared stable branch.
- Create a new branch for each feature or bug fix.
- Write clear commit messages.
- Push your branch to GitHub before merging.

Example:

```bash
git checkout -b feature-session-detail
git add .
git commit -m "Add session detail screen"
git push -u origin feature-session-detail
```

## Suggested Task Distribution

- Session List UI: [Add Name]
- Session Details UI: [Add Name]
- Favorites Feature: [Add Name]
- Login / Logout Screens: [Add Name]
- Testing and GitHub Management: [Add Name]

## Notes

- Update this README when new features are completed.
