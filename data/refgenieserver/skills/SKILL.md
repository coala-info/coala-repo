---
name: refgenieserver
description: refgenieserver provides a web interface and RESTful API for managing and distributing reference genome assets. Use when user asks to list available remote assets, download pre-built genomic indexes, or retrieve remote paths for genome data.
homepage: https://refgenie.databio.org/
---


# refgenieserver

## Overview
refgenieserver provides a web interface and RESTful API for the refgenie ecosystem, allowing for the centralized management and distribution of reference genome assets. This skill enables the standardized organization of genomic data, making it easier to share pre-built indexes and ensure pipeline portability by abstracting local file paths into logical identifiers.

## Core CLI Operations

### Initialization and Configuration
Before using refgenie, you must point to a configuration file and initialize it.
- Set the environment variable: `export REFGENIE='genome_config.yaml'`
- Initialize the config: `refgenie init -c $REFGENIE`

### Managing Remote Assets
Use these commands to interact with a refgenie server (like http://refgenomes.databio.org).
- **List available remote assets**: `refgenie listr`
- **Download (pull) an asset**: `refgenie pull <genome>/<asset>`
  - Example: `refgenie pull hg38/bwa_index`
- **Retrieve remote paths**: `refgenie seekr <genome>/<asset>`
  - Use this to get a URL or S3 path without downloading the full asset.

### Local Asset Management
Once assets are pulled or built, use these commands to integrate them into bioinformatics workflows.
- **Find local path**: `refgenie seek <genome>/<asset>`
  - This returns the absolute path to the asset on the current system, ensuring scripts remain portable.
- **Build custom assets**: `refgenie build <genome>/<asset>`
  - Use this when a specific index is not available on the remote server.

## Best Practices
- **Environment Consistency**: Always define the `REFGENIE` environment variable in your shell profile or workflow manager to ensure the tool can locate your genome configuration.
- **Remote Mode for Cloud**: When working in cloud environments (AWS/GCP), use `refgenie seekr` with the `--remote-class` flag (e.g., `s3`) to stream or reference data directly from object storage.
- **Alias Usage**: Use sequence-derived identifiers for genomes to ensure compatibility between different asset servers, even if you use human-readable aliases like "hg38" locally.

## Reference documentation
- [Refgenie Introduction and CLI Guide](./references/refgenie_databio_org_en_latest.md)
- [Refgenieserver Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_refgenieserver_overview.md)