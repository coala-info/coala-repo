---
name: snakemake-storage-plugin-cached-http
description: This plugin provides high-reliability downloads for Snakemake with local caching, automatic checksum verification, and rate-limit handling for providers like Zenodo and PyPSA. Use when user asks to download remote datasets with caching, verify file integrity via checksums, or manage rate-limited HTTP transfers in Snakemake workflows.
homepage: https://github.com/PyPSA/snakemake-storage-plugin-cached-http
---


# snakemake-storage-plugin-cached-http

## Overview

The `snakemake-storage-plugin-cached-http` plugin is a specialized storage provider for Snakemake designed to handle high-reliability downloads. Unlike the standard HTTP plugin, it includes built-in logic for local caching to prevent redundant transfers, automatic checksum verification against remote APIs (Zenodo, GCS, or PyPSA manifests), and sophisticated rate-limit handling with exponential backoff. It is the preferred tool for workflows relying on large datasets hosted on Zenodo or PyPSA's data infrastructure.

## Installation

Install the plugin via Conda/Mamba from the Bioconda channel:

```bash
conda install -c bioconda snakemake-storage-plugin-cached-http
```

## Usage Patterns

### Basic Rule Integration
The plugin automatically detects supported URLs (zenodo.org, data.pypsa.org, storage.googleapis.com). Use the `storage()` function in your rule inputs:

```python
rule download_dataset:
    input:
        storage("https://zenodo.org/records/3520874/files/natura.tiff")
    output:
        "resources/natura.tiff"
    shell:
        "cp {input} {output}"
```

### Explicit Provider Selection
If multiple plugins support the same URL, or to ensure the cached-http logic is used, call the provider explicitly:

```python
rule download_specific:
    input:
        storage.cached_http("https://data.pypsa.org/workflows/eur/eez/v12_20231025/World_EEZ_v12_20231025_LR.zip")
    output:
        "resources/eez.zip"
    shell:
        "cp {input} {output}"
```

## Configuration and Best Practices

### Global Settings in Snakefile
You can configure the plugin's behavior globally within the Snakefile to control concurrency and cache locations:

```python
storage cached_http:
    provider = "cached-http"
    cache = "~/.cache/snakemake-pypsa-eur"
    max_concurrent_downloads = 3
```

### CI/CD Optimization
In CI/CD environments (like GitHub Actions), you often want to disable caching to save disk space or skip remote metadata checks to speed up the dry-run phase. Use environment variables for these overrides:

*   **Disable Caching**: Set `SNAKEMAKE_STORAGE_CACHED_HTTP_CACHE=""`
*   **Skip Remote Checks**: Set `SNAKEMAKE_STORAGE_CACHED_HTTP_SKIP_REMOTE_CHECKS=1`

Example CLI execution for CI:
```bash
SNAKEMAKE_STORAGE_CACHED_HTTP_CACHE="" SNAKEMAKE_STORAGE_CACHED_HTTP_SKIP_REMOTE_CHECKS=1 snakemake --cores all
```

### Expert Tips
*   **Rate Limits**: The plugin automatically monitors `X-RateLimit-*` headers for Zenodo. If you encounter 429 errors, the plugin will handle the wait time and retry up to 5 times automatically.
*   **Checksum Failures**: If a download completes but the checksum (retrieved from the Zenodo API or PyPSA manifest) doesn't match, the plugin will delete the corrupted file and retry.
*   **Plugin Priority**: This plugin "monkey-patches" the standard Snakemake HTTP plugin to refuse Zenodo and GCS URLs, ensuring that the cached version is used by default when both are installed.
*   **Immutability**: For Zenodo and data.pypsa.org, the plugin returns `mtime=0` because these URLs are considered immutable. For Google Cloud Storage, it uses the actual remote modification time.

## Reference documentation
- [GitHub Repository and README](./references/github_com_PyPSA_snakemake-storage-plugin-cached-http.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-storage-plugin-cached-http_overview.md)