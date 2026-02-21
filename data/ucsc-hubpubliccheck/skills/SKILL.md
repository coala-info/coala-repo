---
name: ucsc-hubpubliccheck
description: The `ucsc-hubpubliccheck` utility is a specialized tool from the UCSC Genome Browser "kent" suite.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-hubpubliccheck

## Overview
The `ucsc-hubpubliccheck` utility is a specialized tool from the UCSC Genome Browser "kent" suite. Its primary function is to perform a consistency check between the labels found in a Track Hub's configuration and the labels stored in the `hubPublic` database table. This ensures that when a hub is listed publicly, the descriptive labels displayed to users correctly reflect the current state of the hub's own settings.

## Usage Instructions

### Environment Setup
Before running the tool, ensure the binary has the correct execution permissions and that your environment is configured to connect to the UCSC databases if necessary.

1.  **Permissions**: If you have downloaded the binary directly, apply execution permissions:
    `chmod +x hubPublicCheck`
2.  **Database Configuration**: Many UCSC utilities require a connection to the public MySQL server. You must have an `.hg.conf` file in your home directory with the appropriate credentials.
3.  **Installation**: The tool is most easily managed via Bioconda:
    `conda install bioconda::ucsc-hubpubliccheck`

### Common CLI Patterns
The tool is typically invoked by providing the hub's URL or the specific database targets you wish to verify.

*   **View Usage**: To see the specific arguments and flags for your version, run the tool with no arguments:
    `hubPublicCheck`
*   **Standard Validation**: Run the check against a specific hub URL to identify discrepancies in label metadata.

### Expert Tips
*   **Label Synchronization**: Use this tool immediately after updating the `shortLabel` or `longLabel` fields in your `hub.txt` or `trackDb.txt` files to ensure the UCSC public directory stays in sync.
*   **Connection Errors**: If the tool fails with a "permission denied" or connection error, verify that your `.hg.conf` file is correctly formatted and that your network allows outgoing connections to port 3306 (MySQL).
*   **Version Consistency**: Since UCSC frequently updates their utilities (e.g., v482), ensure you are using a version that matches your current Genome Browser installation to avoid schema mismatches.

## Reference documentation
- [UCSC Admin Executables Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hubpubliccheck Package Details](./references/anaconda_org_channels_bioconda_packages_ucsc-hubpubliccheck_overview.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)