---
name: rainbow
description: Rainbow Fart is a VSCode extension that plays complimentary audio clips when specific programming keywords are detected in the editor. Use when user asks to enable auditory positive reinforcement, authorize the local audio server, or trigger sounds while coding.
homepage: https://github.com/SaekiRaku/vscode-rainbow-fart
---


# rainbow

## Overview
Rainbow Fart is a unique VSCode extension that provides auditory positive reinforcement while you program. It monitors your editor for specific coding keywords—such as `function`, `if`, or `await`—and plays back complimentary audio clips. Because VSCode restricts direct audio playback, the extension utilizes a local web server and a browser-based authorization flow to function.

## Usage Instructions

### Activation Workflow
To start the extension, users must follow a specific sequence to bypass security restrictions:
1. **Enable**: Open the VSCode Command Palette (`Ctrl+Shift+P` or `Cmd+Shift+P`) and type `Enable Rainbow Fart`.
2. **Authorize**: A notification will appear in the bottom right corner. Click **Open**.
3. **Browser Link**: A browser window will open to a local address (usually `http://127.0.0.1:7788`). Click the **Authorization** button on this page.
4. **Keep Open**: The browser tab must remain open (or minimized) in the background to handle the audio processing.

### Keyword Triggers
The extension reacts to standard programming constructs. To verify it is working, type the following in any active editor:
- `function`
- `if`
- `await`
- `import`

### Configuration and Customization
- **Custom Ports**: If the default port (7788) is occupied, you can customize the port in VSCode settings to avoid conflicts.
- **Voice Packages**: Users can import third-party voice packages. These are typically distributed as zip files and can be imported via the local web interface opened during authorization.
- **Regex Support**: Advanced users can use regular expressions for keyword matching to trigger sounds on specific naming patterns or custom snippets.

## Expert Tips
- **Audio Latency**: If audio feels delayed, ensure the background browser tab is not being "slept" or discarded by the browser's efficiency mode.
- **Privacy**: The extension processes keywords locally to trigger sounds; it does not upload code to external servers for the compliment logic.
- **Volume Control**: Volume is managed through the browser tab's interface rather than VSCode's internal settings.

## Reference documentation
- [Main Repository and Quick Start](./references/github_com_SaekiRaku_vscode-rainbow-fart.md)
- [Release Tags and Version History](./references/github_com_SaekiRaku_vscode-rainbow-fart_tags.md)