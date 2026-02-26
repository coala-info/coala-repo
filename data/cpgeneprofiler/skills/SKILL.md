---
name: cpgeneprofiler
description: cpgeneprofiler is a genomic surveillance tool designed to scan bacterial genome assemblies for carbapenemase genes and analyze their distribution. Use when user asks to identify carbapenemase genes in bacterial isolates, generate cocarriage reports, or visualize antibiotic resistance profiles using heatmaps and intersection plots.
homepage: https://github.com/ramadatta/CPgeneProfiler
---


# cpgeneprofiler

## Overview

`cpgeneprofiler` is a specialized R package and command-line tool designed for genomic surveillance of antibiotic resistance. It streamlines the process of scanning multiple bacterial genome assemblies (FASTA format) against a carbapenemase gene database. Unlike general AMR tools, it focuses specifically on CP genes, providing automated workflows to extract cocarriage data and visualize the results through heatmaps and intersection plots. It is particularly useful for researchers needing to assess the genetic context and distribution of carbapenemases across large datasets of bacterial isolates.

## Installation and Requirements

The tool is designed for Unix-based systems and requires NCBI BLAST+ (version 2.9.0+ recommended) to be available in the system PATH.

### Environment Setup
Install via Conda (recommended):
```bash
conda install -c bioconda cpgeneprofiler
```

Or via R:
```R
install.packages("devtools")
devtools::install_github("ramadatta/CPgeneProfiler")
```

## Core Workflow

The standard analysis follows a sequential execution of R functions. Ensure your input directory contains only the FASTA files you wish to analyze.

### 1. Database Preparation
You must provide a CP gene database in FASTA format. A common source is the NCBI BARRGD CP gene database.
```R
# Example: Downloading the database within R
url <- "https://raw.githubusercontent.com/ramadatta/CPgeneProfiler/master/testData/db/NCBI_BARRGD_CPG_DB.fasta"
download.file(url, "NCBI_BARRGD_CPG_DB.fasta")
```

### 2. Running the Analysis
Execute the BLAST search and filter results based on identity and coverage.

```R
library(CPgeneProfiler)

# Run BLAST alignment
cpblast(fastalocation = "/path/to/assemblies", dblocation = "/path/to/db")

# Filter results (Default: 100% coverage and identity)
filt_blast(cpgcov = 100, cpgpident = 100)
```

### 3. Visualization and Statistics
Generate profiles and plots to interpret the findings.

*   **Cocarriage Report:** `cocarriage(cpgcov = 100, cpgpident = 100)`
*   **Heatmap Profile:** `cpprofile(title = "CP Gene Profile Heatmap")`
*   **UpSet Plot:** `upsetR_plot(nsets = 40, order.by = "degree")`
*   **Contig Length Distribution:** `plot_conlen(outputType = "png")`
*   **Assembly Stats:** `assemblystat(fastalocation = "/path/to/assemblies")`

### 4. Output Management
Consolidate all generated plots and tables into a structured output directory.
```R
cp_summarize(outdir_loc = "/path/to/output", outdir = "Project_Results")
```

## Expert Tips

*   **Path Configuration:** The tool assumes `blastn` and `makeblastdb` are in your system's `$PATH`. If using a custom BLAST installation, update your environment variables before starting the R session.
*   **Strict Filtering:** The default `cpgcov` and `cpgpident` are set to 100. For screening divergent alleles or fragmented assemblies, consider lowering these thresholds (e.g., 95 or 98) in `filt_blast()`.
*   **Input Cleanliness:** Ensure the `fastalocation` directory contains only the target assembly files to avoid BLAST errors or inclusion of unintended sequences in the profile.
*   **Memory Management:** When processing hundreds of assemblies, the `upsetR_plot` can become resource-intensive; adjust the `nsets` parameter to focus on the most frequent gene combinations.

## Reference documentation
- [CPgeneProfiler GitHub Repository](./references/github_com_ramadatta_CPgeneProfiler.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cpgeneprofiler_overview.md)