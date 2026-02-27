---
name: bioconductor-ngsreports
description: The ngsReports package parses, visualizes, and manages quality control data from Next-Generation Sequencing pipelines and log files. Use when user asks to generate automated QC reports, visualize FastQC results, import alignment or assembly logs, or extract specific QC modules into data frames for analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/ngsReports.html
---


# bioconductor-ngsreports

## Overview
The `ngsReports` package provides a framework for parsing, visualizing, and managing QC data from NGS pipelines. It primarily handles FastQC output but also supports log files from alignment, trimming, and assembly tools. It uses S4 classes (`FastqcData` and `FastqcDataList`) to store parsed data, allowing for seamless integration into R-based bioinformatics workflows.

## Core Workflows

### 1. Generating Automated Reports
The fastest way to summarize a project is to point the package at a directory containing FastQC results (zipped or extracted).
```r
library(ngsReports)
fileDir <- "path/to/fastqc_results"
writeHtmlReport(fileDir)
```

### 2. Loading and Querying FastQC Data
For custom analysis, load files into a `FastqcDataList`.
```r
# Identify files
files <- list.files("path/to/data", pattern = "fastqc.zip$", full.names = TRUE)

# Load into R
fdl <- FastqcDataList(files)

# Extract specific modules as tibbles
# Modules: "Summary", "Basic_Statistics", "Per_base_sequence_quality", etc.
stats <- getModule(fdl, "Basic_Statistics")
read_counts <- readTotals(fdl)
```

### 3. Visualization
All plotting functions support both single `FastqcData` objects (standard FastQC-style plots) and `FastqcDataList` objects (heatmaps or faceted summaries). Use `usePlotly = TRUE` for interactive versions.

*   **Summary Status:** `plotSummary(fdl)`
*   **Read Totals:** `plotReadTotals(fdl)`
*   **Sequence Quality:** `plotBaseQuals(fdl)` or `plotSeqQuals(fdl)`
*   **GC Content:** `plotGcContent(fdl, species = "Hsapiens", gcType = "Transcriptome")`
*   **Adapter Content:** `plotAdapterContent(fdl)`

### 4. Importing External Log Files
Use `importNgsLogs()` to parse output from other tools into data frames.
```r
# Supported types: "star", "bowtie", "bowtie2", "hisat2", "trimmomatic", "featureCounts", "busco", "quast", etc.
star_logs <- importNgsLogs(c("sample1_Log.final.out"), type = "star")

# Visualize alignment success
plotAlignmentSummary(c("path/to/logs"), type = "bowtie2")

# Visualize assembly stats (BUSCO/Quast)
plotAssemblyStats(c("quast_report.tsv"), type = "quast")
```

## Tips and Best Practices
*   **Subsetting:** `FastqcDataList` objects can be subset using standard R syntax: `fdl[1:5]`.
*   **Custom GC Profiles:** If your organism isn't in the default `gcTheoretical` object, provide a FASTA file to `plotGcContent(fdl, Fastafile = "my_genome.fa")`.
*   **Exporting Sequences:** Use `overRep2Fasta(fdl)` to export overrepresented sequences for BLAST searching.
*   **Plot Customization:** Since plots are `ggplot2` objects, you can extend them using `+ theme()` or other ggplot layers.

## Reference documentation
- [An Introduction To ngsReports](./references/ngsReportsIntroduction.md)