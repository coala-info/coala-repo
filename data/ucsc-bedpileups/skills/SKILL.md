---
name: ucsc-bedpileups
description: The ucsc-bedpileups utility identifies and reports exact genomic overlaps between features in BED format files. Use when user asks to find overlapping BED entries, identify high-occupancy genomic regions, or collapse features into a pileup representation.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
metadata:
  docker_image: "quay.io/biocontainers/ucsc-bedpileups:482--h0b57e2e_0"
---

# ucsc-bedpileups

## Overview
The `bedPileUps` utility is part of the UCSC Genome Browser "kent" source suite. It is designed to process BED format files to identify exact overlaps between genomic features. Unlike general-purpose tools that might calculate coverage density, `bedPileUps` specifically focuses on finding where BED entries occupy the same genomic space and reporting those overlaps. This is particularly useful for identifying high-occupancy regions in ChIP-seq data, finding redundant annotations, or collapsing overlapping features into a pileup representation.

## Usage Patterns

### Basic Command Structure
The tool typically takes a BED file as input and produces a report of overlaps.
```bash
bedPileUps input.bed output.txt
```

### Common CLI Operations
While specific flags are often minimal for this utility, the following patterns are standard for UCSC BED tools:

*   **Standard Input/Output**: Like most kent utilities, you can often use `stdin` or `stdout` by using a dash `-` in place of a filename, allowing for piping.
    ```bash
    cat data.bed | bedPileUps - stdout
    ```
*   **Pre-sorting**: For optimal performance and to ensure correct overlap detection, always sort your BED files by chromosome and then by start position before running the pileup.
    ```bash
    bedSort input.bed sorted.bed
    ```

### Expert Tips
*   **Exact vs. Inexact Overlaps**: Note that `bedPileUps` is optimized for finding exact overlaps. If you require "fuzzy" overlaps or a specific minimum base-pair overlap threshold, consider using `overlapSelect` or `bedIntersect` from the same suite.
*   **Memory Management**: For extremely large datasets (e.g., whole-genome sequencing pileups), ensure you are using the 64-bit version of the binary (`linux.x86_64`) to avoid memory addressing limits.
*   **Integration with BigBed**: If your data is in BigBed format, use `bigBedToBed` to stream the data into `bedPileUps` without creating large intermediate files.
    ```bash
    bigBedToBed input.bb stdout | bedPileUps stdin output.txt
    ```

## Reference documentation
- [anaconda_org_channels_bioconda_packages_ucsc-bedpileups_overview.md](./references/anaconda_org_channels_bioconda_packages_ucsc-bedpileups_overview.md)
- [hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [github_com_ucscGenomeBrowser_kent.md](./references/github_com_ucscGenomeBrowser_kent.md)