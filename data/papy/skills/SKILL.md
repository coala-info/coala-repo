---
name: papy
description: Papyros Shell is a desktop compositor for Wayland that provides a Material Design environment built with QtQuick and Green Island. Use when user asks to build the shell from source, resolve dependencies, configure the SDDM theme, or run the compositor in windowed or standalone mode.
homepage: https://github.com/papyros/papyros-shell
---


# papy

## Overview
Papyros Shell is a desktop compositor for Wayland built using QtQuick and the Green Island framework, following Google's Material Design guidelines. This skill enables agents to guide users through the specialized build process, dependency resolution, and session management required to run the Papyros environment either as a standalone compositor or a windowed shell.

## Installation and Build Patterns
The shell requires a specific build configuration to ensure QML modules are installed in the correct system paths.

### Building from Source
Execute the following sequence to compile the shell:
```bash
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DQML_INSTALL_DIR=lib/qt/qml
make
sudo make install
```

### Core Dependencies
Ensure the following components are present before building:
- **Frameworks**: Qt 5.5 (with QtWayland), GreenIsland, and QML Material (develop branch).
- **System**: Wayland, PAM (for authentication), and QT5XDG.
- **KDE Frameworks**: KConfig, KDeclarative, Solid, and NetworkManagerQt.

## Running the Shell
The `papyros-session` command is the primary entry point. It behaves differently depending on the environment from which it is launched.

- **Windowed Mode**: Run `papyros-session` from within an existing X11 or Wayland desktop environment to start the shell in a window for testing.
- **Full Compositor**: Run `papyros-session` from a virtual terminal (TTY) to initialize the full Wayland compositor.

## Configuration Best Practices

### SDDM Theme Integration
To enable the Papyros login screen, modify the SDDM configuration file at `/etc/sddm.conf`. Ensure the `[Theme]` section points to the papyros assets:
```ini
[Theme]
Current=papyros
```

### Troubleshooting Shared Libraries
If the shell fails to start with "error while loading shared libraries," verify that the GreenIsland components and Papyros-specific C++ modules are in the system's library path (usually `/usr/lib` or `/usr/local/lib`).

## Expert Tips
- **Arch Linux**: Use the official Papyros Arch repository for binary packages to avoid manual compilation of the extensive dependency tree.
- **Development**: When modifying QML files, you can often test changes in windowed mode without a full system reboot.
- **Hardware Support**: The shell uses Green Island's hardware plugin for battery and sound indicators; ensure `alsa-utils` or `pulseaudio` is installed for the sound indicator to function.

## Reference documentation
- [Papyros Shell README](./references/github_com_papyros_papyros-shell.md)
- [Papyros Wiki](./references/github_com_papyros_papyros-shell_wiki.md)