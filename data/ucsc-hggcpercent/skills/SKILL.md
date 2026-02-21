---
name: ucsc-hggcpercent
description: The `ucsc-hggcpercent` tool (often invoked as `hgGcPercent`) is a specialized utility from the UCSC Genome Browser "kent" source suite.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-hggcpercent

## Overview
The `ucsc-hggcpercent` tool (often invoked as `hgGcPercent`) is a specialized utility from the UCSC Genome Browser "kent" source suite. It is designed to process genomic sequence data and output the percentage of Guanine and Cytosine bases. By default, it operates using 20kb windows, making it ideal for large-scale genomic landscape analysis rather than single-base resolution. It is commonly used to create data tracks that visualize how sequence composition varies across chromosomes.

## Usage Instructions

### Basic Command Pattern
The tool typically requires a database name or a path to a sequence file and an output destination.
```bash
hgGcPercent [database] [output.wig]
```

### Common Requirements
*   **Sequence Data**: The tool usually expects access to genomic sequences. If running locally, this often requires a `.2bit` file representing the genome assembly.
*   **Database Configuration**: If the tool is configured to pull from the UCSC MySQL server, you must have an `.hg.conf` file in your home directory with the appropriate credentials.
*   **Permissions**: If you have downloaded the binary directly from the UCSC servers, ensure it is executable:
    ```bash
    chmod +x hgGcPercent
    ```

### Best Practices
*   **Window Size**: While the tool is optimized for 20kb windows, check the help output (by running the tool without arguments) to see if your version supports the `-win=` or `-doStep=` flags to adjust the window size or step increment.
*   **Output Formats**: The tool typically outputs in wiggle (`.wig`) format. This format is highly compressed and suitable for conversion to `bigWig` using `wigToBigWig` for efficient visualization in genome browsers.
*   **Handling Gaps**: Be aware that regions with high "N" (ambiguous base) counts or assembly gaps may result in lower GC calculations or skipped windows depending on the tool's internal logic for handling non-ACGT bases.

### Troubleshooting
*   **Permission Denied**: Always verify the binary has execution permissions (`chmod +x`).
*   **Missing Database**: If the tool fails to find a genome, ensure your `db` argument matches a valid UCSC assembly ID (e.g., hg38, mm10) and that your environment is configured to point to the sequence source.

## Reference documentation
- [UCSC Binary Downloads Overview](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda ucsc-hggcpercent Package Summary](./references/anaconda_org_channels_bioconda_packages_ucsc-hggcpercent_overview.md)