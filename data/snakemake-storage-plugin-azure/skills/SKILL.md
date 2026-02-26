---
name: snakemake-storage-plugin-azure
description: This plugin enables Snakemake to use Azure Blob Storage as a native file system for managing workflow data. Use when user asks to use Azure Blob Storage for pipeline inputs or outputs, automate data transfers to the Azure cloud, or configure Snakemake storage providers.
homepage: https://github.com/snakemake/snakemake-storage-plugin-azure
---


# snakemake-storage-plugin-azure

## Overview
The `snakemake-storage-plugin-azure` is a specialized extension for Snakemake that allows the workflow management system to treat Azure Blob Storage as a native file system. You should use this skill when your pipeline data (inputs, outputs, or benchmarks) resides in the Azure cloud. It eliminates the need for manual `az copy` commands by allowing Snakemake to handle remote file existence checks, timestamps, and data transfers automatically during execution.

## Installation
Install the plugin via Conda/Mamba from the Bioconda channel:
```bash
conda install bioconda::snakemake-storage-plugin-azure
```

## Core CLI Usage
To enable Azure storage globally for a workflow run, use the following flags:

```bash
snakemake --default-storage-provider azure \
    --default-storage-prefix "az://<container-name>" \
    --storage-azure-account-name <your-account-name> \
    --jobs 1
```

### Key Arguments
- `--default-storage-provider azure`: Instructs Snakemake to use the Azure plugin for all files not otherwise specified.
- `--default-storage-prefix "az://<container>"`: Sets the base URI for your data. You can also use the full URL format: `https://<account>.blob.core.windows.net/<container>`.
- `--storage-azure-account-name`: The name of your Azure Storage account.

## Authentication
The plugin utilizes the standard Azure Python SDK credential chain. It will attempt to authenticate in the following order:
1. **Azure CLI**: If you are logged in via `az login` on the execution machine.
2. **Environment Variables**: `AZURE_STORAGE_KEY` or Service Principal credentials (`AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, `AZURE_TENANT_ID`).
3. **Managed Identity**: If running on an Azure VM or AKS with an assigned identity.

## Expert Tips and Best Practices
- **Memory Management**: Be cautious with extremely large files. Current versions of the plugin may attempt to read blobs into memory during certain operations, which can lead to Out-Of-Memory (OOM) errors on small instances.
- **Directory Support**: The plugin supports directory-level operations. When specifying a directory as an output in a Snakemake rule, the plugin will correctly handle the prefix-based "folder" structure in Azure.
- **Wildcard Searches**: You can use Snakemake wildcards in conjunction with Azure storage; the plugin implements the necessary interface to perform remote globbing/wildcard expansion.
- **Local Testing**: For local development without incurring cloud costs, use the **Azurite** storage emulator.
    - Start Azurite: `docker run -p 10000:10000 mcr.microsoft.com/azure-storage/azurite azurite-blob --blobHost 0.0.0.0`
    - Point Snakemake to the local endpoint by configuring the storage settings to use the emulator connection string.

## Reference documentation
- [Snakemake Azure Storage Plugin Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-storage-plugin-azure_overview.md)
- [GitHub Repository and Usage Examples](./references/github_com_snakemake_snakemake-storage-plugin-azure.md)
- [Known Issues and Bug Reports](./references/github_com_snakemake_snakemake-storage-plugin-azure_issues.md)