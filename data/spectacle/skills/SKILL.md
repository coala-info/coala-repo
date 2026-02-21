---
name: spectacle
description: Spectacle is a keyboard-driven window management utility for macOS that eliminates the need for mouse-based window dragging.
homepage: https://github.com/eczarny/spectacle
---

# spectacle

## Overview

Spectacle is a keyboard-driven window management utility for macOS that eliminates the need for mouse-based window dragging. It allows for precise snapping of windows to halves, thirds, and corners, as well as seamless movement between multiple monitors. Use this skill to provide users with the correct key combinations and behavioral logic for efficient workspace organization.

## Basic Window Placement

Use these shortcuts to snap the active window to primary screen regions:

*   **Center**: `⌥⌘C` (Centers the window without changing its size)
*   **Maximize**: `⌥⌘F`
*   **Left Half**: `⌥⌘←`
*   **Right Half**: `⌥⌘→`
*   **Top Half**: `⌥⌘↑`
*   **Bottom Half**: `⌥⌘↓`

## Corner Snapping

*   **Upper Left**: `⌃⌘←`
*   **Lower Left**: `⌃⇧⌘←`
*   **Upper Right**: `⌃⌘→`
*   **Lower Right**: `⌃⇧⌘→`

## Advanced Resizing and Thirds

Spectacle supports cycling through different widths and moving windows in increments:

*   **Cycle Thirds**: Activate any half or corner shortcut (e.g., `⌥⌘←`) multiple times. Spectacle will cycle the window width between 1/2, 1/3, and 2/3 of the screen.
*   **Next/Previous Third**: Use `⌃⌥→` to move to the next third or `⌃⌥←` for the previous third.
*   **Incremental Resize**:
    *   Make window larger: `⌃⌥⇧→`
    *   Make window smaller: `⌃⌥⇧←`

## Multi-Display Management

Move windows between monitors while maintaining their relative position:

*   **Next Display**: `⌃⌥⌘→`
*   **Previous Display**: `⌃⌥⌘←`

## Window Action History

*   **Undo last action**: `⌥⌘Z`
*   **Redo action**: `⌥⇧⌘Z`

## Expert Tips and Troubleshooting

*   **Accessibility Permissions**: Spectacle requires "Accessibility" permissions under System Preferences > Security & Privacy > Privacy to control other applications.
*   **Terminal Constraints**: Applications like Terminal or iTerm2 may not snap perfectly to edges because they resize based on fixed character grid dimensions (rows/columns). Spectacle will attempt to fit them as closely as possible, which may result in slight gaps or "jitter."
*   **Minimum Size Constraints**: If an application has a hard-coded minimum width/height (e.g., Spotify or certain Preferences windows), Spectacle will respect those constraints even if the shortcut requests a smaller size.
*   **Archived Status**: Note that Spectacle is no longer actively maintained. For users on newer macOS versions experiencing bugs, Rectangle is the recommended open-source alternative that uses the same default shortcuts.

## Reference documentation
- [Spectacle README](./references/github_com_eczarny_spectacle.md)