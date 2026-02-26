---
name: atol-genome-launcher
description: The atol-genome-launcher automates the retrieval of sequencing data from Bioplatforms Australia and organizes it for genome assembly and annotation. Use when user asks to generate RNA-Seq manifests, batch download sequencing reads, or retrieve specific assets using Bioplatforms URLs.
homepage: https://github.com/TomHarrop/atol-genome-launcher
---


# atol-genome-launcher

## Overview

The `atol-genome-launcher` is a utility suite designed to bridge the gap between metadata management and bioinformatic execution. It is primarily used to automate the retrieval of raw sequencing data from Bioplatforms Australia (BPA) and organize it into structured formats suitable for genome assembly and annotation. Use this skill when you need to generate manifests for specific organisms or perform high-throughput downloads of RNA-Seq datasets while maintaining sample integrity.

## Environment Setup

Before using the download utilities, you must provide your Bioplatforms Australia API key.

```bash
export BPA_APIKEY="your_api_key_here"
```

## Core CLI Workflows

### 1. Generating RNA-Seq Manifests
Use `rnaseq-manifest-generator` to query metadata and create a CSV manifest of available RNA-Seq files for a specific organism.

**Pattern:**
```bash
rnaseq-manifest-generator --resources <resources_csv> --packages <packages_csv> <organism_key> <output_manifest_csv>
```

*   **Resources/Packages**: These are the CSV files produced by the `atol-bpa-datamapper`.
*   **Organism Key**: The `organism_grouping_key` used in the Data Mapper.

### 2. Batch Downloading Reads
Once a manifest is generated, use `rnaseq-reads-downloader` to fetch the files. This tool automatically runs the underlying downloader for each entry and combines files by sample.

**Pattern:**
```bash
rnaseq-reads-downloader --parallel_downloads 4 <manifest_csv> <output_directory>
```

*   **Parallelism**: Use `--parallel_downloads` to speed up the process, especially for large datasets.
*   **Sample Handling**: The tool handles the logic of grouping downloaded files into their respective sample folders.

### 3. Individual File Retrieval
For targeted downloads of specific assets from a Bioplatforms URL, use `bpa-file-downloader`.

**Pattern:**
```bash
bpa-file-downloader --file_checksum <expected_hash> <bioplatforms_url> <local_file_name>
```

## Best Practices

- **Checksum Verification**: Always provide the `--file_checksum` when using `bpa-file-downloader` to ensure data integrity during transit.
- **Metadata Sync**: Ensure your `resources.csv` and `packages.csv` are up to date from the `atol-bpa-datamapper` before generating manifests, as the launcher relies entirely on these mappings.
- **Resource Management**: When running `rnaseq-reads-downloader` on HPC environments, match `--parallel_downloads` to the number of cores requested in your job script to optimize throughput without hitting API rate limits or exhausting local I/O.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_TomHarrop_atol-genome-launcher.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_atol-genome-launcher_overview.md)