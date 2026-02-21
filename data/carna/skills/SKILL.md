---
name: carna
description: Carna (based on the Carnac project) is a keyboard logging and presentation utility designed to provide visual insight into keyboard usage.
homepage: https://github.com/Code52/carnac
---

# carna

## Overview
Carna (based on the Carnac project) is a keyboard logging and presentation utility designed to provide visual insight into keyboard usage. It overlays active keystrokes on the screen, making it an essential tool for educators and developers who want to show their audience exactly what shortcuts are being pressed during a session. This skill covers the installation via package managers, basic operational toggles, and the workflow for building the utility from source.

## Installation and Setup
Carna requires the **.NET 4.5.2** framework to function correctly on Windows systems.

### Using Chocolatey
The most efficient way to install the utility is via the Chocolatey package manager:
```bash
cinst carnac
```

### Manual Installation
1. Download the latest release zip file.
2. Unpack the archive to a local directory.
3. Run `Setup.exe` to initiate the installer.

The application uses Squirrel.Windows for updates, meaning it will automatically check for and install new versions in the background. A restart of the application is required to apply updates.

## Operational Best Practices
Carna is designed to be unobtrusive, running in the background and appearing only when keys are pressed.

### Toggling Silent Mode
When you need to type sensitive information (like passwords) or simply want to stop the on-screen display without closing the app, use the global hotkey:
- **Toggle Silent Mode**: `Ctrl` + `Alt` + `P`

Pressing this combination again will resume the keystroke presentation.

### Presentation Tips
- Ensure the utility is started before beginning a screen recording or presentation.
- Use Silent Mode proactively during login sequences or when navigating private file structures.
- If the display fails to appear, verify that the process is not being filtered or that the application hasn't entered an error state due to missing .NET dependencies.

## Development and Building from Source
If you are contributing to the project or need a custom build, follow the standard development workflow.

### Build Workflow
1. Clone the repository to your local machine.
2. Open a terminal (PowerShell or Command Prompt) in the root directory.
3. Execute the build script to compile the code and run unit tests:
   ```powershell
   .\build.ps1
   ```
   *Note: The repository also includes a `build.cake` file for use with the Cake build automation system.*

### Testing Changes
Always run the unit tests included in the build script before deploying a custom version to ensure the Reactive Extensions (Rx) logic for key interception remains stable.

## Reference documentation
- [Carnac the Magnificent Keyboard Utility](./references/github_com_Code52_carnac.md)