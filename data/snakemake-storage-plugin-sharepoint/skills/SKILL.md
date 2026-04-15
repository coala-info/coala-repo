---
name: snakemake-storage-plugin-sharepoint
description: This plugin enables Snakemake to use Microsoft SharePoint as a remote storage system for input and output files. Use when user asks to use SharePoint folders as native storage locations, automate file transfers between Snakemake and SharePoint, or configure SharePoint authentication for workflow execution.
homepage: https://github.com/Hugovdberg/snakemake-storage-plugin-sharepoint
metadata:
  docker_image: "quay.io/biocontainers/snakemake-storage-plugin-sharepoint:0.4.4--pyhdfd78af_0"
---

# snakemake-storage-plugin-sharepoint

## Overview
The `snakemake-storage-plugin-sharepoint` is a specialized extension for Snakemake that treats Microsoft SharePoint as a remote file system. This allows bioinformaticians and data scientists to use SharePoint folders as native input or output locations in their rules. It eliminates the need for manual downloads or local syncing by handling the authentication and file transfer logic directly through the Snakemake storage interface.

## Installation
Install the plugin via Bioconda or pip to make it available to the Snakemake runtime:

```bash
# Via Conda
conda install -c bioconda snakemake-storage-plugin-sharepoint

# Via Pip
pip install snakemake-storage-plugin-sharepoint
```

## Command Line Usage
To use SharePoint as a storage provider, you must specify the plugin and provide the necessary authentication credentials. Snakemake maps plugin settings to CLI arguments using the prefix `--storage-sharepoint-`.

### Basic Execution
Enable the plugin by passing it to the `--storage-plugin` flag:

```bash
snakemake --storage-plugin sharepoint \
    --storage-sharepoint-client-id <YOUR_CLIENT_ID> \
    --storage-sharepoint-client-secret <YOUR_CLIENT_SECRET> \
    --storage-sharepoint-tenant-id <YOUR_TENANT_ID> \
    --storage-sharepoint-site-url <YOUR_SITE_URL> \
    --jobs 4
```

### URI Scheme
When defining inputs or outputs in your Snakefile, use the `sharepoint://` scheme:

```python
# Example usage in a Snakefile
rule download_data:
    input:
        storage.sharepoint("sharepoint://path/to/input_file.txt")
    output:
        "local_file.txt"
    shell:
        "cp {input} {output}"
```

## Best Practices and Expert Tips

### 1. Secure Credential Management
Avoid passing secrets like `client-secret` directly in the CLI to prevent them from appearing in process lists or shell history. Use environment variables instead. Snakemake automatically looks for environment variables in the format `SNAKEMAKE_STORAGE_SHAREPOINT_<SETTING>`:

```bash
export SNAKEMAKE_STORAGE_SHAREPOINT_CLIENT_ID="your-id"
export SNAKEMAKE_STORAGE_SHAREPOINT_CLIENT_SECRET="your-secret"
export SNAKEMAKE_STORAGE_SHAREPOINT_TENANT_ID="your-tenant"
export SNAKEMAKE_STORAGE_SHAREPOINT_SITE_URL="https://tenant.sharepoint.com/sites/yoursite"

snakemake --storage-plugin sharepoint --jobs 4
```

### 2. Overwrite Logic
The plugin includes specific logic for handling file overwrites. If you encounter issues where files are not being updated on SharePoint, ensure your authentication principal has "Write" and "Delete" permissions on the target site, as some SharePoint configurations require deletion before a file can be replaced.

### 3. Path Formatting
SharePoint paths are relative to the `site-url` provided. Ensure your URIs do not redundantly include the site URL or tenant domain if they are already defined in the storage settings.

### 4. Troubleshooting Uploads
If an upload fails, the plugin provides detailed error messages. Common failures are often related to:
- **Token Expiration**: Ensure your Azure App Registration has the correct permissions (typically `Sites.ReadWrite.All` or `Files.ReadWrite.All`).
- **Path Length**: SharePoint has a 400-character limit for the total path length; keep directory structures shallow if possible.

## Reference documentation
- [Anaconda Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-storage-plugin-sharepoint_overview.md)
- [GitHub Repository README](./references/github_com_Hugovdberg_snakemake-storage-plugin-sharepoint.md)