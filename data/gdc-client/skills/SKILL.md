---
name: gdc-client
description: The `gdc-client` is a specialized command-line interface (CLI) designed for robust data transfer between local environments and the NCI Genomic Data Commons.
homepage: https://gdc.cancer.gov/access-data/gdc-data-transfer-tool
---

# gdc-client

## Overview
The `gdc-client` is a specialized command-line interface (CLI) designed for robust data transfer between local environments and the NCI Genomic Data Commons. It is the preferred tool for handling large-scale genomic files (often 200-300 GB) that are prone to failure via standard browser downloads. This skill provides the necessary syntax and operational patterns to execute downloads via manifests, retrieve specific UUIDs, and manage controlled-access data using authentication tokens.

## Core Commands and Usage

### Downloading Data
The `download` command is the primary method for retrieving files.

*   **Download by UUID**: Use for individual files.
    ```bash
    gdc-client download <UUID>
    ```
*   **Download via Manifest**: The most efficient way to download multiple files.
    ```bash
    gdc-client download -m manifest_file.txt
    ```
*   **Specify Output Directory**:
    ```bash
    gdc-client download -m manifest.txt -d /path/to/destination/
    ```

### Handling Controlled Access
For data requiring authorization (e.g., TCGA controlled-access BAMs), you must provide a token file downloaded from the GDC Data Portal.
```bash
gdc-client download -m manifest.txt -t gdc-user-token.txt
```

### Resuming Transfers
One of the tool's primary strengths is its ability to resume. If a transfer is interrupted, simply re-run the exact same command. The client checks the local directory for existing file parts and resumes from the last successful byte.

### Data Submission (Upload)
For users with submission privileges, the `upload` command is used to transfer data to the GDC.
```bash
gdc-client upload -m manifest.txt -t gdc-user-token.txt
```

## Expert Tips and Best Practices
*   **Token Security**: Always keep your GDC authentication token private. Do not hardcode it into scripts that are shared publicly.
*   **Manifest Efficiency**: When working with hundreds of files, always use the manifest method rather than individual UUID commands to take advantage of the tool's internal connection pooling.
*   **MD5 Verification**: The `gdc-client` automatically performs MD5 checksum validation upon completion. If a file fails this check, it will be flagged; ensure you have sufficient disk space, as full disks are a common cause of checksum failures.
*   **Parallel Downloads**: While the client handles some optimization, for extremely large cohorts, consider splitting a large manifest into smaller chunks and running multiple `gdc-client` instances if your network bandwidth and disk I/O allow.

## Reference documentation
- [GDC Data Transfer Tool Overview](./references/gdc_cancer_gov_access-data_gdc-data-transfer-tool.md)
- [Bioconda gdc-client Package Info](./references/anaconda_org_channels_bioconda_packages_gdc-client_overview.md)