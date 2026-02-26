---
name: cct
description: "The cct tool allows users to watch web videos on Android TV devices. Use when user asks to play web videos, watch TV channels, or manage cct settings."
homepage: https://github.com/Eanya-Tonic/CCTV_Viewer
---


# cct

## Overview

The `cct` tool, also known as CCTV Viewer, is a lightweight application designed for watching web videos on set-top boxes and Android TV devices. It allows users to browse and play various TV channels and other web video sources. This skill is intended to help users interact with the `cct` tool, understand its functionalities, and troubleshoot common issues.

## Usage Instructions

The `cct` tool is primarily a GUI application for Android TV and set-top boxes. Direct command-line interaction with `cct` itself is not its primary use case as described in the provided documentation. The documentation focuses on the application's features, installation, and troubleshooting within the Android environment.

Therefore, this skill will focus on providing guidance based on the information available, rather than direct CLI commands for `cct`.

### General Guidance and Troubleshooting

*   **Installation:**
    *   Download the APK from GitHub Releases or other provided links.
    *   Ensure compatibility with your Android version. Older versions (e.g., Android 4.x) may have specific requirements or limitations.
*   **X5 Kernel Integration:**
    *   The application often relies on the Tencent X5 kernel for enhanced web rendering.
    *   If videos are not playing or the application crashes, ensure the correct X5 kernel version is installed.
    *   The application may attempt to download and install the X5 kernel automatically. For 64-bit devices, a specific X5 kernel version (e.g., 46XXX) is required, while 32-bit devices need a different version (e.g., 45XXX).
    *   Troubleshooting X5 kernel installation issues might involve clearing app data or reinstalling the application.
*   **Channel Management:**
    *   Channels can be switched using the up/down arrow keys on a remote or keyboard.
    *   A channel list can be accessed via a menu key or by pressing the confirm button.
    *   Specific channel numbers can be entered using the numeric keypad.
*   **Playback Issues:**
    *   "Sorry, this video cannot be played temporarily" errors might require refreshing the page or checking the X5 kernel.
    *   Black screen issues can sometimes be resolved by replacing the WebView or updating the application.
    *   Consider enabling or disabling features like "double buffering" in the settings for performance optimization on weaker devices.
*   **Configuration:**
    *   Settings can be accessed via the menu button.
    *   Options include:
        *   Direct channel switching with arrow keys.
        *   Customizing channel list font size.
        *   Enabling/disabling double buffering.
        *   Choosing between system WebView and X5 kernel.
        *   Enabling/disabling X5 kernel.
*   **Remote Control Navigation:**
    *   **Up/Down:** Switch channels or navigate channel list.
    *   **Confirm/Enter:** Display current channel info, open channel list, or play/pause (depending on version and settings).
    *   **Menu Key:** Open function menu, channel list, or refresh page (behavior varies by version).
    *   **Back Button:** Exit the application (may require double press to avoid accidental exit).
    *   **Number Keys:** Directly tune to a channel.
    *   **Left/Right Keys:** Zoom in/out on the webpage.

## Reference documentation
- [CCTV_Viewer Overview](./references/github_com_Eanya-Tonic_CCTV_Viewer.md)