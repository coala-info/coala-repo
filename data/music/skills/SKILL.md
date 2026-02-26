---
name: music
description: LX Music is a cross-platform desktop music player that integrates multiple music sources and provides advanced features like a local HTTP API and data synchronization. Use when user asks to assist with technical setup, troubleshoot data paths, develop integrations via the Open API, or configure custom music sources.
homepage: https://github.com/lyswhut/lx-music-desktop
---


# music

## Overview
LX Music is a cross-platform desktop music player built using Electron and Vue 3. It serves as a unified interface for multiple music sources and provides advanced features for power users, including a local HTTP API, data synchronization across devices, and custom source support. This skill should be used to assist with technical setup, troubleshooting data paths, or developing integrations that interact with the LX Music environment.

## Data Management and Paths
LX Music stores user data, playlists, and settings in specific directories based on the operating system. Use these paths for backup, migration, or manual configuration:

- **Linux**: `$XDG_CONFIG_HOME/lx-music-desktop` or `~/.config/lx-music-desktop`
- **macOS**: `~/Library/Application Support/lx-music-desktop`
- **Windows**: `%APPDATA%/lx-music-desktop`
- **Portable Mode (Windows)**: If a folder named `portable` exists within the program directory, the application will use it for all data storage instead of the default AppData path.

## Command Line Usage and Startup
The application supports specific startup parameters to control its initial behavior:

- **Start Minimized**: Use the `hidden` parameter to launch the application in the background/system tray without opening the main window.
  - Example: `lx-music-desktop --hidden`
- **Source Code Development**: To run the application from source for debugging or development:
  1. Clone the repository and switch to the `dev` branch.
  2. Install dependencies: `npm install`
  3. Start in development mode: `npm run dev`

## Open API Integration
Starting from v2.7.0, LX Music includes an Open API service that allows third-party applications to control the player via a local HTTP server.

- **Activation**: Enable the "Open API" feature within the software settings.
- **Functionality**: Once enabled, the software starts a local HTTP service providing interfaces for:
  - Retrieving current playback status.
  - Controlling playback (Play/Pause/Next/Previous).
  - Managing playlists and track information.
- **Use Case**: Use this for creating desktop widgets, keyboard macros, or integration with home automation systems.

## Scheme URL Support
LX Music can be triggered via browser links or other applications using the `lx-music://` protocol (v1.17.0+).

- **Common Pattern**: `lx-music://<action>?<parameters>`
- **Helper Script**: An official Tampermonkey script ("LX Music 辅助脚本") is available to facilitate interaction between web browsers and the desktop client.

## Expert Tips and Best Practices
- **Custom Sources**: If default music sources are unavailable, use the "Custom Source" (自定义源) setting to import external script files that define how the player fetches audio links.
- **Transparency Issues**: On macOS, if you experience background rendering issues with desktop lyrics, ensure "Transparent Window" is disabled, as it is not used by default on that platform to maintain stability.
- **Data Sync**: For multi-device setups, deploy the independent "LX Music Data Sync Service" on a private server to keep playlists synchronized without relying on local file exports.

## Reference documentation
- [LX Music Desktop README](./references/github_com_lyswhut_lx-music-desktop.md)
- [Documentation Index](./references/github_com_lyswhut_lx-music-desktop_tree_master_doc.md)