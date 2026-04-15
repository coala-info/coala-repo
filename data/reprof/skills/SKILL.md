---
name: reprof
description: ReproFed manages Fedora systems using a declarative profile model to ensure the installed packages match a desired state. Use when user asks to apply a system profile, list available configurations, update the tool, or synchronize system state to eliminate configuration drift.
homepage: https://github.com/ephmo/reprofed
metadata:
  docker_image: "biocontainers/reprof:v1.0.1-6-deb_cv1"
---

# reprof

## Overview
ReproFed (reprof) transforms Fedora system management from manual package installation to a desired-state model. It allows users to define their entire system configuration—including third-party repositories like RPM Fusion and VS Code—within profiles. When a profile is applied, the tool ensures that only the declared packages exist on the system, effectively eliminating configuration drift and leftover "bloat" from previous installations.

## CLI Usage and Best Practices

### Core Commands
- **Update Tool**: `sudo reprofed --update`
  Always run this before applying changes to ensure the latest logic and official profiles are available.
- **List Profiles**: `reprofed --list`
  Displays available official profiles (gnome, kde, cosmic, server) and any detected community profiles.
- **Apply Profile**: `sudo reprofed --apply <profile_name>` or `sudo reprofed -a <profile_name>`
  Triggers the synchronization process to match the system state to the chosen profile.

### Safe Execution Workflow
Applying a profile often involves significant package removal and installation, which can crash an active graphical session. Follow this sequence for stability:
1. Save all work and close applications.
2. Switch to a TTY (e.g., `Ctrl` + `Alt` + `F3`).
3. Stop the graphical environment: `sudo systemctl isolate multi-user.target`.
4. Execute the apply command: `sudo reprofed --apply <profile>`.
5. Reboot or return to the graphical target: `sudo systemctl isolate graphical.target`.

### Expert Tips
- **Declarative Awareness**: Remember that ReproFed follows a strict model. Any package or group not explicitly declared in your active profile may be removed during the sync process.
- **Third-Party Repositories**: ReproFed natively manages `rpmfusion-free`, `rpmfusion-nonfree`, `vscode`, and `COPR` repositories. These are only enabled if the active profile explicitly requires them.
- **Customization**: Do not modify official profiles directly, as updates will overwrite them. Instead, create a custom profile or extend a community profile for personal adjustments.
- **Manual Packages**: Packages installed manually via `dnf` after a sync will persist until the next `reprof --apply` command is run, at which point they will be removed if not added to the profile.

## Reference documentation
- [ReproFed Main Documentation](./references/github_com_ephmo_reprofed.md)