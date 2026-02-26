---
name: digestiflow-demux
description: Digestiflow-demux automates Illumina sequencing demultiplexing by integrating raw data processing with the Digestiflow web platform for metadata management and quality tracking. Use when user asks to execute demultiplexing runs, configure API access, perform dry runs, or push quality metrics to a Digestiflow server.
homepage: https://github.com/bihealth/digestiflow-demux
---


# digestiflow-demux

## Overview
The `digestiflow-demux` tool acts as a command-line bridge between raw Illumina sequencing output and the Digestiflow web platform. It automates the complex multi-step process of demultiplexing by pulling metadata and sample sheets from a Digestiflow API, running the actual data conversion via Snakemake-managed workflows, and pushing quality metrics back to the server for centralized tracking. Use this skill to configure the environment, execute demultiplexing runs, and troubleshoot pipeline execution.

## Configuration
Before execution, you must configure access to the Digestiflow Web API via a TOML file located at `~/.digestiflowrc.toml`.

```toml
[web]
url = "https://flowcells.example.org/api"
token = "your_secret_rest_api_token"

[demux]
threads = 16
# Optional: Cluster settings
# drmaa = " -V -cwd -S /bin/bash"
# cluster_config = "/path/to/cluster_config.json"
```

## Common CLI Patterns

### Standard Demultiplexing
To process one or more flowcells and output results to a specific directory:
`digestiflow-demux --project-uuid <UUID> <OUT_PATH> <IN_PATH_1> <IN_PATH_2>`

### Tool Selection
The tool defaults to `bcl2fastq` but can be forced to use `picard` for specific RTA versions:
`digestiflow-demux --demux-tool picard --project-uuid <UUID> <OUT_PATH> <IN_PATH>`

### Partial Processing
For large flowcells, you can restrict processing to specific lanes or tiles to save time or debug issues:
*   **By Lane:** `digestiflow-demux --lane 1 --lane 2 ...`
*   **By Tile:** `digestiflow-demux --tiles <TILE_PATTERN> ...` (Note: Tiles must be selected from all lanes to avoid Snakemake failures).

### Testing and API Safety
*   **Dry Run / Read Only:** To check if a flowcell is ready and pull the sample sheet without writing data or updating the API status:
    `digestiflow-demux --api-read-only --project-uuid <UUID> <OUT_PATH> <IN_PATH>`
*   **Force Execution:** If a flowcell is not marked as "ready" in the Digestiflow UI but you need to run it anyway:
    `digestiflow-demux --force-demultiplexing --project-uuid <UUID> <OUT_PATH> <IN_PATH>`

## Expert Tips & Best Practices
*   **Cleanup:** The tool creates a temporary working directory for Snakemake. If a run fails, use `--keep-work-dir` to inspect the logs and intermediate files.
*   **Resume Prevention:** The tool creates a `DIGESTIFLOW_DEMUX_DONE.txt` file in the output directory upon successful completion. If this file exists, the tool will skip the directory to prevent accidental overwrites.
*   **Automated QC:** The pipeline automatically runs FastQC and MultiQC. The resulting HTML reports and data ZIPs are automatically attached to the Digestiflow server message upon completion.
*   **Post-Processing Only:** If demultiplexing was performed manually or elsewhere, use `--only-post-message` to simply collect existing information and notify the Digestiflow server.

## Reference documentation
- [Digestiflow Demux Overview](./references/anaconda_org_channels_bioconda_packages_digestiflow-demux_overview.md)
- [Digestiflow Demux GitHub Documentation](./references/github_com_bihealth_digestiflow-demux.md)