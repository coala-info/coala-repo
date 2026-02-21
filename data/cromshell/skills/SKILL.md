---
name: cromshell
description: cromshell is a command-line utility that acts as a wrapper for the Cromwell REST API.
homepage: https://github.com/broadinstitute/cromshell
---

# cromshell

## Overview
cromshell is a command-line utility that acts as a wrapper for the Cromwell REST API. It simplifies the lifecycle of genomic and data processing pipelines by providing a local tracking system for submitted jobs. Instead of managing long UUIDs manually, users can reference recent jobs using relative indices (e.g., -1 for the most recent) or custom aliases. It is the primary tool for developers and bioinformaticians working with WDL-based workflows who need to interact with Cromwell from a terminal environment.

## Core Workflows

### Workflow Submission
To submit a new workflow, provide the WDL file and the corresponding input JSON.
- **Basic submission**: `cromshell submit workflow.wdl inputs.json`
- **With options and dependencies**: `cromshell submit workflow.wdl inputs.json options.json dependencies.zip`
- **Validation**: Before submitting, use `cromshell validate workflow.wdl inputs.json` to check for syntax errors using miniwdl or womtool.

### Monitoring and Status
cromshell tracks your submissions locally in `~/.cromshell/`.
- **List recent jobs**: `cromshell list` (use `-c` for color-coded completion status).
- **Check status**: `cromshell status -1` (checks the most recently submitted job).
- **Execution summary**: `cromshell counts -j -1` provides a summarized count of task statuses (Running, Succeeded, Failed) in JSON format.

### Debugging and Metadata
- **Retrieve logs**: `cromshell logs -1` lists the paths to all log files produced by the workflow.
- **Inspect metadata**: Use `cromshell slim-metadata -1` to get a condensed version of the workflow metadata, which is often more readable than the full metadata dump.
- **Timing diagram**: `cromshell timing -1` opens a visual representation of the workflow execution timing in your default browser.

### Resource and Cost Management
- **Abort a job**: `cromshell abort <workflow-id>`
- **Calculate costs**: For workflows run on Google Cloud (GCS) with BigQuery billing export enabled, use `cromshell cost -d -1` to see a detailed task-level cost breakdown. Note that cost data usually takes 24 hours to populate in the cloud provider's billing export.

## Expert Tips and Best Practices
- **Relative Referencing**: You can use negative integers to refer to previous jobs. `-1` is the last job, `-2` is the one before that, etc.
- **Aliases**: For important long-running jobs, assign a readable name: `cromshell alias <workflow-id> "production_run_v1"`. You can then use the alias in place of the UUID for all other commands.
- **Server Switching**: If you work with multiple Cromwell instances (e.g., dev and prod), use `cromshell update-server` to change the target URL for new commands.
- **Timeout Management**: If the server is slow or the metadata is massive, increase the connection timeout using the `-t` flag: `cromshell -t 60 metadata -1`.
- **Reproducibility**: cromshell automatically copies your submitted WDL and JSON files into a local folder named after the job ID in `~/.cromshell/`. Use these local copies to verify exactly what was sent to the server.

## Reference documentation
- [Cromshell GitHub README](./references/github_com_broadinstitute_cromshell.md)
- [Cromshell Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cromshell_overview.md)