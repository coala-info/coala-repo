---
name: refgenie
description: "Refgenie manages reference genome assets for reproducible bioinformatics pipelines. Use when user asks to download, build, or find reference genome assets."
homepage: http://refgenie.databio.org
---


# refgenie

---
## Overview

Refgenie is a powerful command-line tool and Python library designed to streamline the management of reference genome assets. It provides a standardized way to organize, download, and build essential files like BWA or Bowtie2 indexes, FASTA files, and annotations. This ensures that bioinformatics pipelines can easily access and utilize these resources in a portable and reproducible manner, regardless of the computing environment.

## Core Functionality

Refgenie primarily revolves around managing "assets" for different reference genomes. These assets can be pre-built and downloaded from remote servers or custom-built from your own FASTA files.

### Key Commands and Concepts

*   **`refgenie init`**: Initializes a refgenie configuration file and genome data directory. This is the first step before using most other refgenie commands.
    *   `export REFGENIE=/path/to/your/genome_config.yaml` should be set to make the configuration persistent.
*   **`refgenie listr`**: Lists available remote assets from configured servers. Useful for discovering what pre-built assets are available.
*   **`refgenie pull GENOME/ASSET`**: Downloads a specified pre-built asset for a given genome.
    *   Example: `refgenie pull hg38/bwa_index`
*   **`refgenie build GENOME/ASSET`**: Builds a custom asset for a given genome. This requires specifying input files or other assets.
    *   Example: `refgenie build my_custom_genome/bowtie2_index --files fasta=my_genome.fa`
    *   Use `-q` or `--requirements` to see what inputs are needed for a build.
    *   Can use `--docker` or `--bulker` for managing build dependencies.
*   **`refgenie seek GENOME/ASSET`**: Retrieves the local file path to a managed asset. This is crucial for making pipelines portable.
    *   Example: `refgenie seek hg38/salmon_index`
*   **`refgenie list`**: Lists locally available assets.
*   **`refgenie add GENOME/ASSET --path <local_path>`**: Manually adds a custom asset that refgenie will manage.

### Expert Tips

*   **Asset Registry Paths**: Refgenie uses a `GENOME/ASSET:TAG` format for specifying assets. Often, the `:TAG` part can be omitted if you're using the default tag.
*   **Remote Mode**: For cloud environments or temporary use, refgenie can operate in "remote mode" without a persistent configuration file. Commands often end with 'r' (e.g., `listr`, `seekr`).
*   **Dependencies**: When building assets, ensure the necessary software is installed or leverage Docker/Bulker for reproducible builds.
*   **Configuration Management**: Always set the `REFGENIE` environment variable to point to your `genome_config.yaml` file for seamless operation.
*   **Python API**: For programmatic access within scripts, import `refgenconf` and use its `RefGenConf` class to interact with assets.

## Reference documentation
- [Overview](./references/refgenie_databio_org_en_latest_overview.md)
- [Install and configure](./references/refgenie_databio_org_en_latest_install.md)
- [Download pre-built assets](./references/refgenie_databio_org_en_latest_pull.md)
- [Build assets](./references/refgenie_databio_org_en_latest_build.md)
- [Add custom assets](./references/refgenie_databio_org_en_latest_custom_assets.md)
- [Retrieve paths to assets](./references/refgenie_databio_org_en_latest_asset_registry_paths.md)
- [Demo videos](./references/refgenie_databio_org_en_latest_demo_videos.md)