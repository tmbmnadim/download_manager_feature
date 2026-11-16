# Laantech Download Manager

## Overview
The project helps users manage large files on a remote server. It manages downloads and uploads even when the app is in the background.

## Features

- Upload module
- Download module
- Global transfers dashboard
- Pause / resume
- Error handling and retry

## Architecture and Key Design Decisions
Clean Architecture is used here, organized feature by feature.


### Project Structure
The project is divided into three features:
#### 1. Files
Files lists all the available files from the remote server and gives users the option to start and pause/resume downloads from there.
#### 2. Dashboard
Dashboard shows all ongoing transfers and also shows recent transfers.
#### 3. Upload
Upload lets users select and upload files.

There is also a core folder holding the shared building blocks of the project. It contains constants, DI (Dependency Injection), error, navigation, network, and routes. These are essential components for this project.

* Constants hold constant information for the app, for example the base URL of the API.
* DI holds the injection files.
* Error contains the error mapping.
* Navigation has the bottom navigation shell for moving between the Files, Dashboard and Upload screens.
* Network holds the Dio client, the logging interceptor (for debugging), and network info for checking connections.
* Routes lists all the routes of the app and initializes go_router for navigation.
* Theme holds the app theme and some styles.
* Widgets holds shared widgets.

### State Management
BLoC has been used for managing state, as it is scalable and strict about separating layers, which helps keep the code organized.
For authentication and loading files, Cubits were used since they are simpler. For transfers, BLoC was chosen to make use of its stream features.

### Networking
Adding a connectivity listener would help define the connection state, but background_downloader already manages that and automatically pauses and resumes transfers.

### Persistence
Flutter Secure Storage is used to persist user data and the token, so the session stays alive even if the app is closed.
The background_downloader package handles the persistence of files for ongoing downloads.

## Background Execution Strategy
background_downloader handles the downloads in the background. It does this by using WorkManager on Android and URLSession on iOS. The server needs to support HTTP Range requests for resuming.

### Android Platform Limits
Battery optimization might kill the download process if the battery is too low. Android 14+ has rules for long-running tasks.

## Notifications
With more time, background_downloader's own notification system could be used for a quick and easy implementation.

## Error Handling and Resilience
The errors are mostly handled in the repository. The caught errors are common ones, such as FormatException and TypeError. The repository returns a generic Failure message, which eases error handling for the state manager. Errors flow upward starting from the source. No errors are handled in the sources. Instead, a few expected errors are caught in the repository and transformed into a generic Failure for easier management.

## Known Limitations and Future Improvements
* Upload is not implemented.
* Notifications are not configured.
* Cleartext HTTP is enabled for the mock server.
* There is no token refresh.
* There are no tests.

## Run Instructions
Run `fvm flutter pub get`, then `fvm dart run build_runner build`, then `fvm flutter run`.

### Prerequisites
Flutter (3.44.9), FVM, and an Android device or emulator are required.

### Setup
Flutter version 3.44.9 is used since it is more stable than the latest one. Use FVM to speed up the setup.

### Build and Run
Run `fvm dart run build_runner build` to generate the dependency injection file, since the project uses injectable. Then run `fvm flutter run`.

### APK
A prebuilt Android APK is available for download:
[Download APK](https://drive.google.com/file/d/15pnLebf2Pq_7pHa16ZPDZxBvyUmt6hyz/view?usp=sharing)

## Project Links
- Source code: [github.com/tmbmnadim/download_manager_feature](https://github.com/tmbmnadim/download_manager_feature)
- APK: [Google Drive](https://drive.google.com/file/d/15pnLebf2Pq_7pHa16ZPDZxBvyUmt6hyz/view?usp=sharing)
