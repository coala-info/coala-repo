---
name: pear
description: Pear is a cross-platform desktop application that provides an enhanced native interface for YouTube Music with support for custom plugins and themes. Use when user asks to install the desktop player, set up a local development environment, or create custom plugins and CSS themes.
homepage: https://github.com/pear-devs/pear-desktop
---


# pear

## Overview
Pear (formerly YouTube Music Desktop) is a cross-platform desktop application that enhances the music listening experience with a native look and feel. This skill assists with the deployment of the application across Windows, macOS, and Linux, and provides the necessary technical guidance for developers to extend the player's functionality through its modular plugin system and CSS-based theming engine.

## Installation Commands

### macOS
Install via Homebrew:
```bash
brew install pear-devs/pear/pear-desktop
```
*Note: If you encounter a "developer cannot be verified" error, run: `sudo xattr -cr /Applications/Pear\ Desktop.app`*

### Windows
Install via Winget or Scoop:
```bash
winget install pear-devs.pear-desktop
# OR
scoop bucket add extras
scoop install extras/pear-desktop
```

### Linux (Arch)
Install from the AUR:
```bash
# Using an AUR helper like yay
yay -S pear-desktop
```

## Development Workflow
To set up a local development environment, ensure you have `pnpm` installed.

1. **Clone and Install**:
   ```bash
   git clone https://github.com/pear-devs/pear-desktop
   cd pear-desktop
   pnpm install --frozen-lockfile
   ```
2. **Run Development Server**: `pnpm dev`
3. **Build Production Version**: `pnpm build`
4. **Run Tests**: `pnpm test`

## Plugin Development
Plugins allow for manipulating the Electron `BrowserWindow` or the renderer's HTML/CSS.

### Plugin Structure
Create a new directory in `src/plugins/[plugin-name]` with an `index.ts` file.

**Core Plugin Template:**
```typescript
import { createPlugin } from '@/utils';

export default createPlugin({
  name: 'My Plugin',
  restartNeeded: true,
  config: {
    enabled: false,
  },
  backend: {
    start({ window, ipc }) {
      // Electron main process logic
    },
    stop() {}
  },
  renderer: {
    start(context) {
      // DOM manipulation logic
    },
    onPlayerApiReady(api, context) {
      // Interact with the music player API
    }
  }
});
```

### Injecting Custom CSS
To modify the UI without complex logic, use the `stylesheets` property:
1. Create a `style.css` in your plugin folder.
2. Import it using the `?inline` query in `index.ts`.
3. Add it to the `stylesheets` array in `createPlugin`.

## Reference documentation
- [Pear Desktop Main Repository](./references/github_com_pear-devs_pear-desktop.md)
- [Pear Desktop Wiki](./references/github_com_pear-devs_pear-desktop_wiki.md)