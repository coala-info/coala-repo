---
name: snakesee
description: snakesee is a passive monitoring tool that provides a real-time dashboard and time estimation for Snakemake workflows. Use when user asks to monitor workflow progress, check job status, estimate completion time, or manage timing profiles.
homepage: https://github.com/nh13/snakesee
---


# snakesee

## Overview
`snakesee` is a passive monitoring tool that provides a rich dashboard for Snakemake workflows. It functions by reading metadata directly from the `.snakemake/` directory, meaning it requires no special flags or configuration during the actual workflow execution. It is particularly useful for long-running bioinformatics pipelines where real-time progress tracking and time estimation are critical.

## Core Commands

### Real-Time Monitoring
The primary mode of operation is the live dashboard.
- **Watch current directory**: `snakesee watch`
- **Watch specific path**: `snakesee watch /path/to/workflow`
- **Adjust refresh rate**: `snakesee watch --refresh 5.0` (Default is 2.0s)

### Status Snapshots
For a quick one-time summary of the workflow state without entering the TUI:
- **Check status**: `snakesee status`
- **Disable ETA**: `snakesee status --no-estimate` (Useful if historical data is irrelevant or missing)

## Advanced Usage and Optimization

### Time Estimation Strategies
`snakesee` uses historical data in `.snakemake/metadata/` to predict remaining time. You can tune this behavior based on your environment:
- **Index-Based (Default)**: Best for active development. Weights the most recent runs higher.
  `snakesee watch --weighting-strategy index --half-life-logs 10`
- **Time-Based**: Best for stable production pipelines. Weights runs based on wall-clock age.
  `snakesee watch --weighting-strategy time --half-life-days 7`
- **Wildcard Conditioning**: Use when different inputs (e.g., different sample sizes) have vastly different runtimes.
  `snakesee watch --wildcard-timing` (or press `w` in the TUI)

### Portable Timing Profiles
You can share timing data across different machines or environments to "seed" the estimator for new runs.
- **Export data**: `snakesee profile-export --output timing.json`
- **Import/Use profile**: `snakesee watch --profile timing.json`
- **Show profile contents**: `snakesee profile-show .snakesee-profile.json`

## TUI Navigation and Shortcuts
- **Vim-style keys**: Use `j`/`k` for navigation and `g`/`G` for top/bottom.
- **Filtering**: Use `/` to filter jobs or rules.
- **Layouts**: Toggle between Full, Compact, and Minimal modes to fit your terminal size.
- **Wildcards**: Press `w` to toggle wildcard-specific timing.

## Custom Progress Plugins
If using specific tools (like BWA, STAR, or samtools), `snakesee` can parse their logs for internal job progress. You can add custom parsers by placing Python scripts in `~/.config/snakesee/plugins/`. A plugin must inherit from `ToolProgressPlugin` and implement `can_parse` and `parse_progress` methods.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_nh13_snakesee.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_snakesee_overview.md)