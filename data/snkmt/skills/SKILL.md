---
name: snkmt
description: snkmt is a terminal-based monitoring tool for tracking Snakemake workflow progress and inspecting errors through an interactive dashboard. Use when user asks to monitor Snakemake workflows, launch the interactive terminal dashboard, track job progress, or manage the execution database.
homepage: https://github.com/cademirch/snkmt
---


# snkmt

## Overview
snkmt (Snakemate) is a terminal-based monitoring tool designed specifically for Snakemake workflows. It captures execution events via a dedicated logger plugin, stores them in a local SQLite database, and provides an interactive dashboard to track job progress and inspect errors without leaving the terminal.

## Core Workflow
To use snkmt, you must first ensure the logger plugin is installed and then invoke it during your Snakemake runs.

### 1. Installation
Install the logger plugin (which includes the snkmt CLI as a dependency):
`pip install snakemake-logger-plugin-snkmt`

### 2. Executing with Monitoring
Run your Snakemake workflow with the snkmt logger enabled:
`snakemake --logger snkmt [other-snakemake-options]`

### 3. Launching the Dashboard
Open the real-time TUI to monitor active or past workflows:
`snkmt console`

## CLI Reference & Patterns
- **Custom Database Path**: By default, snkmt uses the XDG Base Directory. Specify a custom location for shared environments or specific projects:
  `snkmt console --db-path /path/to/workflow.db`
- **Database Maintenance**:
  - View metadata and stats: `snkmt db info [DB_PATH]`
  - Upgrade schema after updates: `snkmt db migrate [DB_PATH]`

## TUI Navigation Tips
- **Navigation**: Use `Tab` and `Shift+Tab` to move between the workflow list, rule tables, and log views.
- **Selection**: Press `Enter` on a workflow row to drill down into specific job statuses or to open log files.
- **Modals**: Use `Escape` to quickly dismiss any open dialogs or error inspection windows.
- **Exit**: Press `q` or `Ctrl+C` to close the console.

## Reference documentation
- [snkmt Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_snkmt_overview.md)
- [snkmt GitHub Repository](./references/github_com_cademirch_snkmt.md)