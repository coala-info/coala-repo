---
name: gap
description: MacGap is a minimalist WebKit wrapper that transforms web technologies into native macOS applications with small binary footprints. Use when user asks to scaffold new projects, build application bundles, or integrate web code with macOS system features like notifications and window management.
homepage: https://github.com/MacGapProject/MacGap1
---


# gap

## Overview
MacGap is a minimalist WebKit wrapper that allows web developers to transform HTML, CSS, and JavaScript into native macOS applications. Unlike heavier alternatives, MacGap produces extremely small binaries (often under 1MB) by utilizing the operating system's built-in WebKit engine. This skill guides the process of scaffolding new projects, building binaries, and utilizing the `macgap` JavaScript API to bridge the gap between web code and macOS system functionality.

## CLI Usage and Workflow

### Installation
MacGap is distributed as a Ruby gem. Ensure Ruby is installed on the system before proceeding.
```bash
gem install macgap
```

### Project Lifecycle
1.  **Initialize**: Create a new project directory with the required boilerplate.
    ```bash
    macgap new myapp
    ```
2.  **Development**: Place all web assets (HTML, CSS, JS) inside the `public/` folder. The application entry point is always `public/index.html`.
3.  **Build**: Compile the project into a `.app` bundle.
    ```bash
    macgap build myapp
    ```

## JavaScript API Integration
The framework injects a global `macgap` object into the WebView. Use this object to interact with macOS features.

### System Notifications
Use the Growl-style notification system for user alerts:
```javascript
macgap.growl.notify({
  title: "Application Alert",
  content: "The task has been completed successfully."
});
```

### Dock Interaction
Modify the application's appearance in the macOS Dock:
```javascript
// Set a notification badge
macgap.dock.badge = "5";

// Clear the badge
macgap.dock.badge = "";
```

### Window Management
Control the native window properties directly from your scripts:
```javascript
// Check if the window is currently active
if (macgap.window.isActive()) {
  // Perform action
}

// Move or resize the window
macgap.window.move({x: 100, y: 100});
macgap.window.resize({width: 800, height: 600});
```

## Best Practices
*   **Lightweight Assets**: Since MacGap's primary advantage is its small footprint, avoid including heavy node_modules or unnecessary libraries in the `public/` folder.
*   **Native Feel**: Use the `macgap.menu` API to create native macOS top-bar menus rather than trying to simulate them with HTML/CSS.
*   **Path Handling**: Use `macgap.path.documents` or `macgap.path.resource` to resolve file locations correctly within the macOS sandbox.
*   **Debugging**: Enable Developer Tools via the application menu or by programmatically triggering the inspector to debug the WebView content.

## Reference documentation
- [MacGap Project Overview](./references/github_com_MacGapProject_MacGap1.md)
- [MacGap Wiki and API Reference](./references/github_com_MacGapProject_MacGap1_wiki.md)