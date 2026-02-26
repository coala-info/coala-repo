---
name: gencove
description: Gencove manages high-throughput genomic data workflows by automating file uploads, tracking sample processing, and retrieving analysis deliverables. Use when user asks to upload sequencing reads, track sample status, list projects, or download analysis results.
homepage: https://docs.gencove.com
---


# gencove

## Overview

The Gencove skill provides a streamlined interface for managing high-throughput genomic data workflows. It enables the automation of file uploads to Gencove's low-pass sequencing pipeline, tracking of sample processing status, and retrieval of analysis deliverables. This skill is essential for bioinformaticians and researchers who need to integrate Gencove's cost-effective sequencing services into their local or cloud-based data pipelines.

## Installation and Setup

The Gencove CLI requires Python 3.8+.

### Installation
```bash
# Standard installation
pip install gencove

# Alternative using uv (no environment setup required)
uvx gencove upload <local-directory-path>

# Bioconda installation
conda install bioconda::gencove
```

### Authentication
Configure credentials via environment variables to avoid interactive prompts:

```bash
# Option A: API Key (Recommended)
export GENCOVE_API_KEY='your-api-key'

# Option B: Email and Password
export GENCOVE_EMAIL='your-email'
export GENCOVE_PASSWORD='your-password'
```
*Note: Do not use both methods simultaneously. API keys bypass MFA requirements.*

## Common CLI Patterns

### Regional Host Configuration
Gencove operates in multiple geographical regions. If your web dashboard URL is `web.eu1.gencove.com`, you must specify the corresponding API host:

```bash
gencove <command> --host https://api.eu1.gencove.com
```

### Data Uploads
Upload a directory of sequencing reads (FASTQs or CRAMs) to a specific project:

```bash
# Basic upload
gencove upload /path/to/reads --project-id <uuid>

# Upload with specific host and API key
gencove upload /path/to/reads --host https://api.eu1.gencove.com --api-key $GENCOVE_API_KEY
```

### Project and Sample Management
*   **List Projects**: View available projects and their IDs.
*   **List Samples**: Check the status of samples within a project.
*   **Download Results**: Retrieve VCFs, reports, and other deliverables once analysis is complete.

## Expert Tips

*   **Mac OS Installation**: Install using `pip install --user gencove` and ensure `~/bin` is in your `$PATH` to avoid system Python conflicts.
*   **Automation**: Use API keys for headless environments (CI/CD, HPC clusters) to ensure scripts do not hang on MFA prompts.
*   **Environment Check**: Always verify your `--host` parameter matches the region where your project was created, as data is not shared across regional silos.

## Reference documentation

- [Gencove Getting Started](./references/docs_gencove_com_base_getting-started.md)
- [Gencove Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gencove_overview.md)