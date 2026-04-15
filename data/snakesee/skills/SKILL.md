---
name: snakesee
description: snakesee is a passive monitoring tool and terminal dashboard that tracks Snakemake workflow progress by reading local metadata. Use when user asks to monitor Snakemake workflows in real-time, view execution status snapshots, or estimate completion times using historical data.
homepage: https://github.com/nh13/snakesee
metadata:
  docker_image: "quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0"
---

# snakesee

## Overview

snakesee is a passive monitoring tool and terminal dashboard for Snakemake workflows. Unlike active monitors that require specific logger plugins or server configurations, snakesee functions by directly reading the `.snakemake/` directory and its associated metadata. This allows for zero-configuration monitoring of any existing workflow, providing real-time progress tracking, historical execution browsing, and data-driven time estimation.

## Core Commands

### Real-Time Monitoring
The primary way to use snakesee is the `watch` command, which opens the interactive TUI.
- `snakesee watch`: Monitor the workflow in the current directory.
- `snakesee watch /path/to/workflow`: Monitor a workflow at a specific location.
- `snakesee watch --refresh 5.0`: Adjust the TUI refresh interval (default is 2.0 seconds).

### Static Status Snapshots
For a quick summary without entering the interactive TUI, use the `status` command.
- `snakesee status`: Print a one-time snapshot of the current workflow progress to the terminal.
- `snakesee status --no-estimate`: View status without calculating the estimated time of arrival (ETA).

## Interactive TUI Features

When using `snakesee watch`, the interface supports several navigation and display modes:
- **Vim-style Controls**: Use standard movement keys for navigating job lists and historical records.
- **Layout Modes**: Toggle between Full, Compact, and Minimal display modes to suit your terminal size and information density needs.
- **Historical Browsing**: Navigate through past workflow executions stored in the Snakemake metadata to compare performance or check previous failure points.

## Time Estimation Logic

snakesee provides ETAs by analyzing historical execution data found in `.snakemake/metadata/`. It employs three primary strategies:
1. **Weighted**: Used when significant historical data exists for specific rules (High confidence).
2. **Simple**: Used when no history exists but some jobs in the current run have completed (Medium confidence).
3. **Bootstrap**: Used at the very start of a workflow with no prior data (Low confidence).

To disable this feature if it is producing inaccurate results due to highly variable job environments, use the `--no-estimate` flag.

## Best Practices

- **Passive Integration**: Always prefer snakesee when you cannot or do not want to modify the `snakemake` execution command, as it requires no `--logger` or `--wms-monitor` flags.
- **Resource Management**: In environments with slow file systems (like some network-attached storage), increase the `--refresh` interval to reduce I/O overhead.
- **Troubleshooting**: Use the `status` command in shell scripts or cron jobs to log workflow progress to a file without the overhead of a TUI.



## Subcommands

| Command | Description |
|---------|-------------|
| snakesee profile-export | Export timing profile from workflow metadata. |
| snakesee profile-show | Display contents of a timing profile. |
| snakesee status | Show a one-time status snapshot (non-interactive). |
| snakesee watch | Watch a Snakemake workflow in real-time with a TUI dashboard. |

## Reference documentation
- [snakesee README](./references/github_com_nh13_snakesee_blob_main_README.md)
- [snakesee Usage Guide](./references/snakesee_readthedocs_io_en_latest_usage.html.md)
- [snakesee CLI Reference](./references/snakesee_readthedocs_io_en_latest_reference_snakesee_cli.html.md)