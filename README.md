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
Clean Architecture is the winner here since we're going feature wise. 

### Project Structure
The project is devided into three features: 
#### 1. Files
Files will list all the available files from the remote server and give users option to start and pause/resume download from there.
#### 2. Dashboard
Dashboard show all ongoing transfers and also show recent transfers.
#### 3. Upload
Upload will let users select and upload files.

Theres is the core folder holding core things for the project. This contains constants, di(Dependency Injection), error, navigation, network, routes. These are some essential components for this project.

* Constants hold constant information for the app, for example: Base Url of the api.
* di holds the injection files.
* error contains mapping for errors
* navigation has the bottom nav shell for navigation withing Files, Dashboard and Upload Screen
* network holds dio client, logging interceptor(for debugging), and network info for checking connections
* routes lists all the routes of the app and initializes go router for navigation
* theme is for app theme and some styles
* widget holds shared widgets

### State Management
BLoC has been used for managing state as it's scallable and is more strict towards seprating layers and helping keep code sorted. 
For Authentication and Loading Files, Cubits were used since this is simpler. But for transfers BLoC was selected to use its stream features.

### Networking

### Persistence
Used Flutter Secure Storage to persist user data and token so that session can stay even if the app is closed. 
And background_downloader package handles the persistance of files for ongoing downloads.

## Background Execution Strategy
background_downloader handles the downlods in the background.

### Android Platform Limits

### iOS Notes

## Notifications

## Error Handling and Resilience
The errors were mostly handled in the repository. Catched errors are common errors like FormatException, TypeError.

## Assumptions

## Known Limitations and Future Improvements

## Run Instructions

### Prerequisites

### Setup

### Build and Run

### API Configuration

### APK

## Project Links
