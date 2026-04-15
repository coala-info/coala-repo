---
name: digestiflow-cli
description: The digestiflow-cli tool automates the registration and synchronization of Illumina sequencing flow cells with the Digestiflow management system. Use when user asks to ingest flow cell directories, update sequencing run metadata, or generate adapter index histograms for quality control.
homepage: https://github.com/bihealth/digestiflow-cli
metadata:
  docker_image: "quay.io/biocontainers/digestiflow-cli:0.5.8--hc234bb7_7"
---

# digestiflow-cli

## Overview

The `digestiflow-cli` is a Rust-based tool designed to automate the interaction between Illumina sequencing hardware and the Digestiflow management system. It parses standard sequencer outputs (like `RunParameters.xml` and `RunInfo.xml`) to register flow cells in a project, update their status, and generate index histograms from BCL files. This ensures that the Digestiflow Web interface accurately reflects the current state of sequencing runs and provides quality control metrics for adapter sequences.

## Configuration

Before use, create a configuration file at `~/.digestiflowrc.toml`. This file stores your API credentials and default execution parameters.

```toml
threads = 4

[web]
# The API entry URL (must end in /api)
url = "https://your-digestiflow-instance.org/api"
# Obtain this from Digestiflow Web > User Icon > API Tokens
token = "your_secret_api_token"

[ingest]
analyze_adapters = true
```

## Core Command: Ingest

The primary function of the tool is the `ingest` command, which synchronizes local flow cell directories with the server.

### Basic Usage
To import one or more flow cell directories into a specific project:

```bash
digestiflow-cli ingest --project-uuid <UUID> /path/to/flowcell_dir
```

### Metadata Extraction
The tool automatically extracts the following from the flow cell directory:
- Sequencer Vendor ID and Run Number.
- Flow cell Vendor ID.
- Planned read sequences (template and barcode/index reads).
- Current sequencing progress.

## Advanced CLI Patterns

### Controlling Registration and Updates
By default, the tool registers new flow cells and updates existing ones if they are in "initial" or "in progress" states. Use these flags to modify that behavior:

- `--no-register`: Do not create new flow cell entries on the server.
- `--no-update`: Do not update existing flow cell metadata.
- `--update-if-state-final`: Force updates even if the flow cell is marked as "complete" or "failed" in Digestiflow.
- `--dry-run`: Preview actions without making changes to the Digestiflow Web instance.

### Adapter Analysis
If `--analyze-adapters` is active, the tool computes histograms of observed indices to help catch sample sheet errors.

- `--force-analyze-adapters`: Re-run the histogram calculation even if the data already exists on the server.
- `--sample-reads-per-tile <N>`: Limit the number of reads processed per tile to speed up analysis (default is typically 1,000,000).

### Performance Tuning
For high-throughput environments, adjust the threading to balance speed and system load:

```bash
# Use 8 threads for faster BCL parsing during adapter analysis
digestiflow-cli --threads 8 ingest --project-uuid <UUID> /path/to/flowcell_dir
```

## Troubleshooting and Best Practices

- **API URL**: Ensure the `url` in your config ends with `/api`. If the web interface is at `https://flowcells.example.com`, the API URL is `https://flowcells.example.com/api`.
- **Permissions**: Ensure the user running the CLI has read access to the Illumina output directories, especially the `Data/Intensities/BaseCalls` subdirectories for adapter analysis.
- **State Management**: If a flow cell is not updating, check its state in the Web UI. If it is no longer "in progress," you must use the `--update-if-state-final` flag.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_bihealth_digestiflow-cli.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_digestiflow-cli_overview.md)