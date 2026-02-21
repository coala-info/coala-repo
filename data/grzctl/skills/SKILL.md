---
name: grzctl
description: grzctl is the primary administrative tool for the Genome Resource Center (GRZ).
homepage: https://github.com/BfArM-MVH/grz-tools
---

# grzctl

## Overview
grzctl is the primary administrative tool for the Genome Resource Center (GRZ). While the related grz-cli tool is used for external submissions, grzctl is designed for internal administrators to monitor the submission pipeline, manage the backend database, and generate compliance reports. It provides a suite of commands for tracking submission states, performing database maintenance, and visualizing data through a Terminal User Interface (TUI).

## Installation
Install grzctl via the bioconda channel:
```bash
conda install bioconda::grzctl
```

## Common CLI Patterns

### Submission Management
Use these commands to track and inspect data submitted to the GRZ.
*   **List submissions**: `grzctl submission list`
    *   Use `--filter` to narrow results.
    *   Use `--since <date>` and `--until <date>` to filter by submission windows.
*   **View submission details**: `grzctl submission show <submission_id>`
    *   Add `--json` to get machine-readable output for scripting.
*   **Inbox Inspection**: `grzctl inbox`
    *   Lists files currently in the landing zone, including file sizes and version markers.

### Database Operations
grzctl manages the internal submission database (supporting both SQLite and PostgreSQL).
*   **Interactive Management**: `grzctl db tui`
    *   Launches a terminal-based interface for browsing the database.
*   **Synchronization**: `grzctl db sync-from-inbox`
    *   Updates the database based on the current state of the submission inbox.
*   **QC Status**: `grzctl db should-qc`
    *   Determines which submissions are eligible for quality control processing.

### Reporting and Archival
*   **Generate Reports**: `grzctl report`
    *   Used for generating quarterly reports.
    *   Note: The `identifiers.le` configuration is optional for this command.
*   **Archival Redaction**: `grzctl redact`
    *   Used during archival processes to remove sensitive information from metadata.json files.

## Expert Tips
*   **State Management**: Submissions with null IDs are automatically ignored in quarterly reports to prevent data corruption.
*   **Date Handling**: The submission date is automatically set to the date the metadata.json upload finished, ensuring accurate tracking of the submission timeline.
*   **Configuration**: grzctl supports merging multiple configuration files, allowing for separate environment-specific and user-specific settings.

## Reference documentation
- [grzctl Overview](./references/anaconda_org_channels_bioconda_packages_grzctl_overview.md)
- [GRZ Tools Monorepo](./references/github_com_BfArM-MVH_grz-tools.md)
- [Release Tags and Features](./references/github_com_BfArM-MVH_grz-tools_tags.md)