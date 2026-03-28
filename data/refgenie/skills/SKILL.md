---
name: refgenie
description: Refgenie is a reference genome manager that standardizes the storage, retrieval, and building of bioinformatics assets. Use when user asks to manage reference genomes, download pre-built genomic assets, retrieve local file paths for indexes, or build custom genome assemblies.
homepage: http://refgenie.databio.org
---


# refgenie

## Overview
Refgenie is a reference genome manager that standardizes how bioinformatics assets are stored and accessed. It eliminates the need for hard-coding paths to genome indexes by providing a "seek" mechanism. It operates on a "pull-or-build" logic: you can download professionally curated assets from a remote server or generate your own for custom assemblies using scripted recipes.

## Core Workflows

### 1. Initialization
Before using refgenie locally, you must initialize a configuration file and subscribe to an asset server.
```bash
# Initialize the config
export REFGENIE=genome_config.yaml
refgenie init -c $REFGENIE

# Subscribe to the default public server
refgenie subscribe -s http://rg.databio.org
```

### 2. Managing Assets (Pull & Seek)
The most common use case is downloading an index and retrieving its path for a tool.
```bash
# List available remote assets
refgenie listr

# Download an asset (e.g., hg38 fasta)
refgenie pull hg38/fasta

# Get the local path to use in a command
refgenie seek hg38/bowtie2_index
```

### 3. Building Custom Assets
If an asset isn't on the server, build it locally. Most builds require a `fasta` asset to exist first.
```bash
# 1. Build the fasta asset from a local file
refgenie build custom_genome/fasta --files fasta=/path/to/genome.fa

# 2. Build derived assets (e.g., bwa_index) using the fasta asset
refgenie build custom_genome/bwa_index
```

## Asset Registry Paths
Refgenie uses a standardized string format: `genome/asset.seek_key:tag`.
- **Defaults**: If you omit the tag, it uses `default`. If you omit the seek_key, it uses the asset name.
- **Example**: `hg38/fasta.fai:default` refers to the index file of the default hg38 FASTA asset.

## Expert Tips
- **Remote Seek**: Use `refgenie seekr` to get URLs for assets hosted on the cloud (e.g., S3) without downloading them.
- **Aliases**: If you have a genome digest but want to call it "hg38", use `refgenie alias set --aliases hg38 --digest <digest>`.
- **Requirements Check**: Before building, check what files or parameters a recipe needs: `refgenie build hg38/bowtie2_index -q`.
- **Concurrency**: When running many builds in a HPC environment, use the `--map` flag to build metadata separately, then `refgenie build --reduce` to merge them into the main config.



## Subcommands

| Command | Description |
|---------|-------------|
| populater | Populate registry paths with remote paths. |
| refgenie | refgenie - reference genome asset manager |
| refgenie build | Build genome assets. |
| refgenie compare | Compare two genomes. |
| refgenie getseq | Get sequences from a genome. |
| refgenie init | Initialize a genome configuration. |
| refgenie list | List available local assets. |
| refgenie populate | Populate registry paths with local paths. |
| refgenie pull | Download assets. |
| refgenie remove | Remove a local asset. |
| refgenie seek | Get the path to a local asset. |
| refgenie seekr | Get the path to a remote asset. |
| refgenie subscribe | Add a refgenieserver URL to the config. |
| refgenie tag | Tag an asset. |
| refgenie unsubscribe | Remove a refgenieserver URL from the config. |
| refgenie upgrade | Upgrade config. This will alter the files on disk. |
| refgenie_add | Add local asset to the config file. |
| refgenie_id | Return the asset digest. |
| refgenie_listr | Remote refgenie assets |

## Reference documentation
- [Refgenie Overview](./references/refgenie_databio_org_en_latest_overview.md)
- [Asset Registry Paths](./references/refgenie_databio_org_en_latest_asset_registry_paths.md)
- [Building Assets](./references/refgenie_databio_org_en_latest_build.md)
- [Available Assets & Recipes](./references/refgenie_databio_org_en_latest_available_assets.md)
- [Genome Aliases](./references/refgenie_databio_org_en_latest_aliases.md)