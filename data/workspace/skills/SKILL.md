---
name: workspace
description: AppFlowy is a privacy-centric, open-source collaborative workspace designed as an alternative to Notion.
homepage: https://github.com/AppFlowy-IO/AppFlowy
---

# workspace

## Overview
AppFlowy is a privacy-centric, open-source collaborative workspace designed as an alternative to Notion. It utilizes a Flutter frontend and a Rust backend to provide a native experience across macOS, Windows, Linux, iOS, and Android. This skill enables an agent to manage the development lifecycle, from initial environment setup to internationalization workflows and cross-platform builds.

## Development Environment Setup
The workspace requires both Flutter and Rust toolchains. To initialize the environment:
- Execute the installation script: `bash install.sh`
- Ensure the Rust environment is configured to support the core logic compilation.
- Navigate to the `frontend` directory for all UI-related development.

## Build and Task Automation
The project relies on `cargo-make` for orchestrating Rust tasks and standard Flutter commands for the interface.
- Use `cargo make` to run predefined build scripts for the Rust components.
- Use `flutter run` or `flutter build` within the `frontend/` directory to manage the application layer.
- Check `codemagic.yaml` for insights into specific build pipeline configurations for different platforms.

## Translation and Internationalization
AppFlowy manages translations through JSON files and the Inlang framework.
- To add or update translations:
  - Manually edit JSON files located in `frontend/resources/translations`.
  - Use the CLI command: `npx inlang machine translate` to automatically detect and translate missing strings.

## Repository Navigation
- `frontend/`: Core Flutter application and UI components.
- `frontend/resources/translations`: Localization assets.
- `doc/`: Technical documentation and OS-specific development instructions.
- `.github/workflows/`: CI/CD logic for Rust-CI, Flutter-CI, and Mobile-CI.

## Expert Tips
- **Data Control**: When self-hosting, refer to the AppFlowy Cloud documentation for data sovereignty configurations.
- **Performance**: If working on storage logic, note that the project uses composite indexes for SQLite to optimize offline sync.
- **Commits**: The workspace enforces strict commit linting. Ensure commit messages follow the project's `commitlint.config.js` standards.

## Reference documentation
- [AppFlowy Main Repository](./references/github_com_AppFlowy-IO_AppFlowy.md)
- [AppFlowy Documentation Tree](./references/github_com_AppFlowy-IO_AppFlowy_tree_main_doc.md)
- [CI/CD Workflows](./references/github_com_AppFlowy-IO_AppFlowy_actions.md)