---
name: cromshell
description: Cromshell provides a command-line interface for managing the lifecycle of WDL workflows through the Cromwell REST API. Use when user asks to submit WDL jobs, track workflow status, retrieve execution logs, or abort running tasks from the terminal.
homepage: https://github.com/broadinstitute/cromshell
---


# cromshell

## Overview
Cromshell provides a streamlined command-line interface for managing the lifecycle of WDL (Workflow Description Language) jobs. It eliminates the need for manual CURL commands to the Cromwell REST API by providing high-level subcommands for submission, status tracking, and log retrieval. It is particularly useful for bioinformaticians and data engineers running large-scale genomic pipelines who need to quickly check job progress or troubleshoot failures from the terminal.

## Core Workflows

### Workflow Submission
To submit a new job, you need the WDL file and an inputs JSON.
- **Basic submission**: `cromshell submit workflow.wdl inputs.json`
- **With options**: `cromshell submit workflow.wdl inputs.json options.json`
- **With dependencies**: If your WDL imports other WDLs, provide them in a zip: `cromshell submit workflow.wdl inputs.json options.json dependencies.zip`

### Monitoring and Status
Cromshell tracks the "current" workflow (usually the last one submitted) to save you from typing long UUIDs.
- **Check status**: `cromshell status`
- **Summarize job counts**: `cromshell counts` (use `-j` for JSON output or `-x` to collapse subworkflows)
- **List recent jobs**: `cromshell list` (if supported by the local installation)

### Troubleshooting and Metadata
- **Get logs**: `cromshell logs` (retrieves execution logs for the workflow)
- **View metadata**: `cromshell metadata` or `cromshell slim-metadata` for a condensed version.
- **Timing diagram**: `cromshell timing` opens a visual representation of task execution in a browser.

### Job Management
- **Alias a job**: `cromshell alias <workflow-id> <my_experiment_name>` to reference it easily later.
- **Abort a job**: `cromshell abort <workflow-id>`

## Expert Tips
- **Server Configuration**: Use `--cromwell_url http://your-server:port` if the default environment variable is not set.
- **Timeouts**: For large metadata requests that might hang, use `-t [SECONDS]` to increase the connection timeout (default is 5s).
- **Authentication**: If your server is behind a proxy requiring Google Auth, use `--gcloud_token_email [EMAIL]` to automatically attach an access token.
- **Relative Referencing**: Many commands accept negative integers to refer to previous jobs (e.g., `cromshell status -2` checks the second-to-last submitted job).



## Subcommands

| Command | Description |
|---------|-------------|
| abort | Abort a running workflow. |
| alias | Label the given workflow ID or relative id with the given alias. Aliases can be used in place of workflow IDs to reference jobs. |
| cost | Get the cost for a workflow. Only works for workflows that completed more than 24 hours ago on GCS. Requires the 'bq_cost_table' key in the cromshell configuration file to be set to the big query cost table for your organization. |
| counts | Get the summarized statuses of all tasks in the workflow. |
| cromshell_list | List the status of workflows. |
| list-outputs | List all output files produced by a workflow. |
| logs | Get a subset of the workflow metadata. |
| metadata | Get the full metadata of a workflow. |
| slim-metadata | Get a subset of the workflow metadata. |
| status | Check the status of a Cromwell workflow. |
| submit | Submit a workflow and arguments to the Cromwell Server |
| timing | Analyze and display timing information for a Cromwell workflow. |
| update-server | Update the cromwell server in the following config file /root/.cromshell/cromshell_config.json |
| validate | Validate a WDL workflow and its input JSON using the Cromwell server's womtool API and miniwdl. |

## Reference documentation
- [Cromshell README](./references/github_com_broadinstitute_cromshell_blob_main_README.md)