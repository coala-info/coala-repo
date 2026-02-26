---
name: bcbio_monitor
description: "bcbio_monitor provides a web-based interface to visualize and track the real-time progress of bcbio-nextgen sequencing pipelines. Use when user asks to monitor bcbio-nextgen logs, visualize execution flowcharts, or track the status of remote and local bioinformatics analyses."
homepage: https://github.com/guillermo-carrasco/bcbio-nextgen-monitor
---


# bcbio_monitor

## Overview
The `bcbio_monitor` skill provides a specialized interface for interacting with the bcbio-nextgen-monitor tool. This tool acts as a web-based extension for the bcbio-nextgen toolkit, transforming standard text-based debug logs into an interactive visualization. It allows bioinformaticians to track the real-time progress of high-throughput sequencing pipelines, view execution flowcharts, and identify bottlenecks or errors through a Flask-powered web application.

## Installation and Setup
The tool can be deployed via common package managers:
- **Conda**: `conda install -c bioconda bcbio_monitor`
- **Pip**: `pip install bcbio_monitor`

## Command Line Usage
The primary way to interact with the monitor is by pointing the CLI at a bcbio log file.

### Basic Monitoring
To start the web server and monitor a specific log file:
`bcbio_monitor bcbio-nextgen-debug.log`

### Customizing the Dashboard
You can provide a custom title for the web interface to distinguish between different projects or runs:
`bcbio_monitor bcbio-nextgen-debug.log --title "Project_Alpha_Run_01"`

### Path Handling
If you provide a directory path instead of a specific file, the tool will automatically look for a file named `bcbio-nextgen-debug.log` within that directory.

## Configuration Best Practices
The tool looks for a configuration file at `~/.bcbio/monitor.yaml`. While the tool can run with default settings, specific parameters can be defined for advanced use cases:

- **Server Settings**: You can define the `SERVER_NAME` (e.g., localhost:5000) and toggle `DEBUG` mode for the Flask application.
- **Remote Monitoring**: To monitor an analysis running on a different machine, the configuration supports a `remote` section. You must specify the `host`, `username`, and optionally the `port` and `password`. If this section is configured, the tool uses SSH to fetch log data.
- **Logging Verbosity**: The internal logging level of the monitor itself can be adjusted to `INFO`, `WARN`, `ERROR`, or `DEBUG`. The default is `INFO`.

## Expert Tips
- **Remote vs. Local**: If the `remote` section is missing from the configuration file, `bcbio_monitor` defaults to local file system reading. This is ideal for post-analysis reviews or when running the monitor on the same node as the analysis.
- **SSH Connectivity**: When monitoring remote runs, ensure SSH keys are properly configured if you wish to avoid entering passwords in the configuration file.
- **Visualizing Finished Runs**: The tool is not only for active runs; it is highly effective for generating a visual summary and flowchart of completed analyses to verify that all steps were executed as expected.

## Reference documentation
- [bcbio-nextgen-monitor GitHub Repository](./references/github_com_guillermo-carrasco_bcbio-nextgen-monitor.md)
- [Bioconda bcbio_monitor Overview](./references/anaconda_org_channels_bioconda_packages_bcbio_monitor_overview.md)