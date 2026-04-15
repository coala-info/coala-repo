---
name: bioconductor-genomes
description: This tool retrieves and analyzes genome and assembly metadata from NCBI reports using the R package genomes. Use when user asks to download genome reports, list assembly summaries, or filter organism metadata from NCBI FTP servers.
homepage: https://bioconductor.org/packages/release/bioc/html/genomes.html
---

# bioconductor-genomes

name: bioconductor-genomes
description: Access and analyze NCBI genome and assembly reports. Use this skill when you need to download, filter, or summarize genome metadata from the NCBI GENOME_REPORTS or ASSEMBLY_REPORTS directories using the R package 'genomes'.

# bioconductor-genomes

## Overview

The `genomes` package provides a streamlined interface for retrieving genome and assembly metadata directly from NCBI's FTP servers. It is primarily used for large-scale comparative genomics planning, tracking sequencing progress, and obtaining FTP paths for various organisms (prokaryotes, eukaryotes, viruses, etc.).

## Core Workflows

### Loading the Package
```r
library(genomes)
```

### Retrieving Reports
The primary function is `reports()`. By default, it lists available files in the NCBI `GENOME_REPORTS` directory.

*   **List available report files:**
    ```r
    reports()
    ```

*   **Download a specific report:**
    Pass the filename (as seen in the list above) to download and parse the table into a data frame.
    ```r
    # Download prokaryote metadata
    proks <- reports("prokaryotes.txt")

    # Download eukaryote metadata
    euks <- reports("eukaryotes.txt")
    ```

### Working with Assembly Reports
To access the `ASSEMBLY_REPORTS` directory instead of the default genome reports, set the `assembly` argument to `TRUE`.

```r
# List assembly reports
reports(assembly = TRUE)

# Download a specific assembly summary
asm_summary <- reports("assembly_summary_genbank.txt", assembly = TRUE)
```

### Data Manipulation
Since `reports()` returns standard R data frames (using `readr` internally), you can use standard `dplyr` or base R functions to filter results.

```r
# Example: Filter for finished genomes with a specific GC content
finished_proks <- subset(proks, Status == "Complete Genome")
```

## Usage Tips
*   **Internet Connection:** This package requires an active internet connection to fetch data from NCBI FTP.
*   **Caching:** The package downloads files to temporary locations; if you are performing extensive filtering, save the resulting data frame to a local file (e.g., `saveRDS()` or `write.csv()`) to avoid redundant downloads.
*   **Column Names:** NCBI report formats change occasionally. Always check `colnames(df)` after downloading a report to ensure your filtering logic matches the current schema.

## Reference documentation
- [Genome and assembly reports](./references/genomes.md)