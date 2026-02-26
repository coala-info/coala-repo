---
name: ucsc-pslhisto
description: The `ucsc-pslhisto` tool aggregates statistics from PSL alignment files to produce frequency counts for generating histograms. Use when user asks to 'aggregate statistics from PSL alignment files', 'produce frequency counts from alignment data', 'prepare data for alignment histograms', or 'analyze alignment distributions for quality control'.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-pslhisto

## Overview
The `pslHisto` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed to aggregate statistics from PSL alignment files. It processes alignment data to produce frequency counts, which serve as the raw input for generating histograms. This is particularly useful for quality control of genomic alignments, allowing researchers to visualize the distribution of alignment lengths, identity percentages, or other scoring metrics across a large dataset.

## Usage Guidelines

### Basic Command Structure
The tool typically reads from a PSL file and outputs a tab-separated count file.
```bash
pslHisto input.psl output.histo
```

### Common Workflow Patterns
1.  **Data Preparation**: Ensure your alignment data is in the standard PSL format (the default output of `blat`).
2.  **Count Collection**: Run `pslHisto` to generate the distribution data.
3.  **Visualization**: Use the resulting output file with downstream tools:
    *   **R**: Load the table for advanced plotting (e.g., `ggplot2`).
    *   **textHistogram**: Use the companion UCSC utility `textHistogram` for a quick CLI-based visual representation of the data.

### Expert Tips
*   **Piping**: Like most UCSC kent utilities, `pslHisto` can often be used in command-line pipes. If the tool supports `stdin`, use `/dev/stdin` or `-` as the input filename depending on the specific version's behavior.
*   **Permissions**: If you have downloaded the binary directly from the UCSC server, remember to set executable permissions: `chmod +x pslHisto`.
*   **Database Connectivity**: While `pslHisto` itself is a file-processor, if you are using it in conjunction with tools that query UCSC's public MySQL server, ensure you have a valid `.hg.conf` file in your home directory.

## Reference documentation
- [Bioconda ucsc-pslhisto Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-pslhisto_overview.md)
- [UCSC Executable Directory Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)