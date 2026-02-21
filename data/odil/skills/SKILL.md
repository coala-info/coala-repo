---
name: odil
description: Odilia is a high-performance, open-source screen reader designed specifically for the *nix desktop environment.
homepage: https://github.com/odilia-app/odilia
---

# odil

## Overview
Odilia is a high-performance, open-source screen reader designed specifically for the *nix desktop environment. Written in Rust, it focuses on speed and stability. It operates as a beta-stage tool that interfaces with the system's speech-dispatcher to provide accessibility services. This skill assists in the technical setup and execution of the Odilia environment.

## Installation and Setup

### Prerequisites
Before installing Odilia, ensure your system meets the following requirements:
*   **Rust Toolchain**: Minimum Supported Rust Version (MSRV) is 1.88.0.
*   **Speech Dispatcher**: The `speech-dispatcher` service must be installed and active.
*   **Verification**: Test speech output by running:
    ```bash
    spd-say "hello, world!"
    ```
    If no audio is heard, troubleshoot your system's sound configuration or speech-dispatcher setup before proceeding.

### Building from Source
Odilia consists of multiple components that should be installed via `cargo`. Follow this sequence to clone and install the necessary binaries to `~/.cargo/bin`:

```bash
git clone https://github.com/odilia-app/odilia
cd odilia
cargo install --path input-server-keyboard
cargo install --path odilia
```

## Usage and Operation

### Running the Screen Reader
Once installed, start the service by simply typing the command in your terminal:
```bash
odilia
```

### Troubleshooting and Logs
If Odilia behaves unexpectedly or fails to start, check the default log file for error messages:
*   **Log Location**: `~/.odilia.log`
*   **Common Issues**: Ensure that the `input-server-keyboard` was installed correctly, as it handles the input interception required for screen reading functionality.

### Cross-Compilation
For developers looking to build Odilia for different architectures:
*   Use the `cross` tool.
*   It is recommended to use the `podman` container engine.
*   Set the environment variable: `CROSS_CONTAINER_ENGINE=podman`.

## Best Practices
*   **Beta Awareness**: Odilia is currently in Beta. Do not rely on it as a primary accessibility tool for production-critical environments.
*   **Environment**: Ensure your user has the necessary permissions to access input devices, as the keyboard server requires specific access to intercept keystrokes.
*   **Updates**: Since the project is in active development, frequently pull the latest changes from the repository and re-run the `cargo install` commands to stay up to date with bug fixes.

## Reference documentation
- [Odilia README](./references/github_com_odilia-app_odilia.md)
- [Odilia Commits](./references/github_com_odilia-app_odilia_commits_main.md)