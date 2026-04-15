---
name: reapr
description: Reapr translates Decent Espresso machine hardware communication into standardized web technologies to enable custom skins, plugins, and real-time telemetry. Use when user asks to set up the bridge environment, build for ARM64 targets, manage espresso profiles, develop JavaScript plugins, or troubleshoot machine connectivity.
homepage: https://github.com/tadelv/reaprime
metadata:
  docker_image: "biocontainers/reapr:v1.0.18dfsg-4-deb_cv1"
---

# reapr

## Overview
Streamline Bridge (reaprime) is a cross-platform connectivity layer that translates Decent Espresso machine (DE1/Bengle) hardware communication into standardized web technologies. It enables developers to build custom "skins" (WebUIs) and plugins while providing real-time telemetry for pressure, temperature, and weight. This skill facilitates the setup, development, and operational management of the bridge environment.

## Operational Best Practices

### Environment Setup and Building
- Use the provided wrapper script `./flutter_with_commit.sh run` instead of standard `flutter run` to ensure version information and Git metadata are correctly injected into the build.
- For Linux ARM64 targets (common for espresso tablets), utilize the containerized build flow:
  - Initialize the environment: `make colima-arm`
  - Execute the build: `make build-arm`
- Ensure the Microsoft Visual C++ Redistributable is installed when deploying on Windows.

### API and Connectivity
- Access the REST API and WebSocket streams on port `8080` for machine control and real-time telemetry.
- Access the WebUI/Skins on port `3000`.
- To browse local API documentation, navigate to `assets/api/` and serve it locally (e.g., `npx httpserver -p 4001`).
- Use "Gateway Modes" to define control hierarchy:
  - **Disabled**: Local control only.
  - **Tracking**: Monitor shot progress and auto-stop at target weight.
  - **Full**: Enable complete remote machine delegation.

### Profile and Workflow Management
- Upload espresso profiles using the `v2 JSON` format, compatible with standard DE1 app profiles.
- Leverage the content-based hashing system for profile identification to prevent duplicate storage and ensure version integrity.
- Configure "Workflows" to combine specific profiles with target weights for automated shot termination.

### Plugin Development
- Extend functionality using the JavaScript plugin system. Plugins can react to machine state changes, make HTTP requests, and serve custom endpoints.
- Ensure every plugin includes a valid manifest structure to define its capabilities and entry points.
- Utilize bundled plugins like `visualizer.reaplugin` for real-time data rendering and `settings.reaplugin` for dashboard configuration.

### Troubleshooting
- If the in-app WebView on Android tablets (especially Teclast models) shows a blank screen, update the "Android System WebView" via the Play Store or APKMirror.
- Use the "Device Simulation" mode during development to test UI and logic without requiring physical hardware connectivity.
- Check Bluetooth 4.0+ compatibility and ensure the app has necessary location/nearby device permissions on Android for BLE discovery.

## Reference documentation
- [Streamline Bridge Overview](./references/github_com_tadelv_reaprime.md)
- [Documentation Index](./references/github_com_tadelv_reaprime_tree_main_doc.md)
- [Issue Tracker and Feature Requests](./references/github_com_tadelv_reaprime_issues.md)