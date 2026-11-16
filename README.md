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

### State Management
BLoC has been used for managing state as it's scallable and is more strict towards seprating layers and helping keep code sorted. 

### Networking

### Persistence

## Background Execution Strategy

### Approach

### Android Platform Limits

### iOS Notes

## Notifications

## Error Handling and Resilience

## Assumptions

## Known Limitations and Future Improvements

## Run Instructions

### Prerequisites

### Setup

### Build and Run

### API Configuration

### APK

## Project Links
