---
name: snakemake-storage-plugin-http
description: The `snakemake-storage-plugin-http` is a specialized extension for Snakemake (version 8+) that enables the seamless integration of web-based resources into data pipelines.
homepage: https://github.com/snakemake/snakemake-storage-plugin-http
---

# snakemake-storage-plugin-http

## Overview
The `snakemake-storage-plugin-http` is a specialized extension for Snakemake (version 8+) that enables the seamless integration of web-based resources into data pipelines. It allows users to define remote URLs as input files, which the plugin then manages by downloading and caching them as needed during workflow execution. This eliminates the need for manual `wget` or `curl` steps within rules, providing a more declarative way to handle remote dependencies.

## Installation
Install the plugin via Conda/Mamba from the Bioconda channel:
```bash
conda install -c bioconda snakemake-storage-plugin-http
```

## CLI Usage and Patterns

### Basic Execution
To use the HTTP storage plugin as the default provider for remote files in a Snakemake run, use the `--default-storage-provider` flag:
```bash
snakemake --default-storage-provider http --storage-http-settings <settings>
```

### Handling Restricted Servers (Disabling HEAD Requests)
Some web servers or CDNs do not support the HTTP `HEAD` verb, which Snakemake often uses to check for file existence or metadata without downloading the full content. If you encounter errors related to unsupported methods, use the flag to disable `HEAD` requests:
```bash
snakemake --storage-http-disable-head
```
*Note: Disabling HEAD requests may increase overhead as the plugin might need to initiate a GET request to verify file properties.*

### Performance and Troubleshooting
*   **Slow DAG Creation**: When targeting remote files (especially within compressed archives like ZIP files), DAG creation can become slow because the plugin may need to query remote metadata for every file. Ensure your network connection is stable and consider using local mirrors for extremely large numbers of small remote files.
*   **Compression Issues**: Be aware that there are known issues with transparently decompressing certain formats like Brotli. If a remote server sends Brotli-compressed content, the plugin may not decode it correctly in older versions. Ensure you are using version 0.3.0 or later.
*   **Authentication**: Current versions of the plugin have limited support for passing complex authentication (like custom API keys in headers) directly from the command line. If the remote resource requires more than basic auth, you may need to handle the download via a standard `shell` command or a different provider until header support is fully implemented.

## Best Practices
*   **Version Pinning**: Always ensure you are using at least version 0.3.0 to benefit from the latest interface updates and the ability to disable HEAD requests.
*   **Input Size Awareness**: Note that remote input files may sometimes report a size of zero (`input.size_mb`) in certain Snakemake versions due to how metadata is retrieved. Do not rely on Snakemake's internal size-based resource scheduling for HTTP-sourced files without verification.

## Reference documentation
- [snakemake-storage-plugin-http - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_snakemake-storage-plugin-http_overview.md)
- [GitHub - snakemake/snakemake-storage-plugin-http](./references/github_com_snakemake_snakemake-storage-plugin-http.md)
- [Issues · snakemake/snakemake-storage-plugin-http](./references/github_com_snakemake_snakemake-storage-plugin-http_issues.md)
- [Tags · snakemake/snakemake-storage-plugin-http](./references/github_com_snakemake_snakemake-storage-plugin-http_tags.md)