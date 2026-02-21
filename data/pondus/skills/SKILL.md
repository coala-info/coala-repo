---
name: pondus
description: Pondus is a lightweight personal weight management tool designed for speed and simplicity.
homepage: https://github.com/enicklas/pondus
---

# pondus

## Overview
Pondus is a lightweight personal weight management tool designed for speed and simplicity. It enables users to maintain a history of body weight and composition metrics (fat, muscle, and water percentages). Beyond simple logging, it features a weight planner for setting target goals and a plotting engine to visualize trends over time. Use this skill to understand how to interact with the pondus CLI, manage its data files, and utilize its workflow shortcuts.

## Command Line Usage
Pondus is primarily a graphical application, but it supports specific command line arguments for configuration and data management.

### Basic Commands
*   **Launch GUI**: Simply run `pondus` to start the application.
*   **Custom Data File**: Use the `-i` or `--input` flag to point to a specific XML data file instead of the default location.
    ```bash
    pondus -i ~/path/to/my_weight_data.xml
    ```
*   **Check Version**: `pondus --version`

### Data Storage
By default, pondus stores all user information in:
`~/.pondus/user_data.xml`

Data is automatically saved upon exiting the application.

## Data Import and Export
Pondus supports interoperability with other fitness tracking software and generic data formats.

*   **CSV Format**: To import data from a spreadsheet or other tool, ensure the CSV follows the standard `YYYY-MM-DD,Weight` format.
    *   Example: `2024-05-20,75.5`
*   **Supported Backends**: The tool includes built-in support for importing/exporting data from SportsTracker.

## GUI Workflow and Shortcuts
To maximize efficiency when entering data, use the following keyboard shortcuts within the interface:

| Shortcut | Action |
| :--- | :--- |
| **Ctrl + A** | Add a new dataset |
| **Ctrl + E** / **Enter** | Edit the selected dataset |
| **Ctrl + D** / **Delete** | Delete the selected dataset |
| **Ctrl + P** | Generate weight vs. time plot |
| **Ctrl + Q** | Quit the application |

### Expert Entry Tips
*   **Quick Adjustments**: In the "Add" dialog, use the **+** and **-** keys to increment or decrement the date by one day or the weight by 0.1 units.
*   **Fast Confirmation**: Pressing **Enter** in any entry field acts as a shortcut for clicking the "OK" button.
*   **Weight Planner**: Enable the weight planner in **Preferences** to toggle between "Measurements" and "Plan" views at the bottom of the main window.

## Requirements
To ensure all features (especially plotting) work correctly, the following dependencies should be present:
*   Python (>= 3.7)
*   PyGObject (>= 3.38)
*   matplotlib (>= 3.0) — *Required for plotting functionality*

## Reference documentation
- [Pondus README](./references/github_com_enicklas_pondus.md)