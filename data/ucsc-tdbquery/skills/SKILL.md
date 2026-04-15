---
name: ucsc-tdbquery
description: The ucsc-tdbquery tool queries and filters metadata from the UCSC Genome Browser's track database. Use when user asks to select track fields, filter tracks by type or keywords, or extract track configuration parameters.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-tdbquery:482--h0b57e2e_0"
---

# ucsc-tdbquery

## Overview
The `ucsc-tdbquery` tool (often invoked as `tdbQuery`) provides a command-line interface to interact with the UCSC Genome Browser's `trackDb` (Track Database) system. This system stores the configuration and metadata for every track available in the browser. This skill allows you to perform complex filtering and selection of track metadata using a syntax similar to SQL, which is significantly more efficient than manual parsing of trackDb files.

## Usage Guidelines

### Prerequisites
*   **Database Access**: Many UCSC utilities require a connection to the public MySQL server (e.g., `genome-mysql.soe.ucsc.edu`).
*   **Configuration**: You must have an `.hg.conf` file in your home directory with valid credentials to connect to the UCSC database.
*   **Permissions**: Ensure the binary has executable permissions (`chmod +x tdbQuery`) if you are running a manually downloaded version.

### Common CLI Patterns
While specific flags are often discovered by running the tool without arguments, the standard functional pattern for `tdbQuery` involves:

1.  **Basic Selection**: Selecting specific fields (like `track`, `shortLabel`, `type`) from the track database for a specific assembly (e.g., `hg38`).
2.  **Filtering**: Using `where` clauses to find tracks of a certain type (e.g., `where type="bigWig"`) or tracks containing specific keywords in their labels.
3.  **Metadata Extraction**: Retrieving the underlying configuration parameters for tracks to use in downstream automation or custom track hub generation.

### Best Practices
*   **Assembly Specificity**: Always specify the database/assembly (e.g., `hg19`, `hg38`, `mm10`) you are targeting, as track configurations vary significantly between versions.
*   **SQL Syntax**: Use standard SQL operators (`=`, `!=`, `LIKE`, `AND`, `OR`) within your query strings.
*   **Output Redirection**: Since `trackDb` queries can return large amounts of text, always redirect output to a file or pipe it to `less` for inspection.
*   **Public MySQL**: If the tool fails to connect, verify that your network allows outgoing traffic on port 3306 to the UCSC public MySQL server.

## Reference documentation
- [ucsc-tdbquery Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-tdbquery_overview.md)
- [UCSC Admin Executables Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)